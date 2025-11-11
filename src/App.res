// Main App component

open Types

@react.component
let make = () => {
  let currentRoute = Router.useRoute()
  let (userProgress, setUserProgress) = React.useState(() => LocalStorage.loadProgress())
  let (database, setDatabase) = React.useState(() => DatabaseLoader.NotLoaded)

  // Load database on mount
  React.useEffect0(() => {
    setDatabase(_ => DatabaseLoader.Loading)

    DatabaseLoader.loadDatabase(
      db => setDatabase(_ => DatabaseLoader.Loaded(db)),
      error => setDatabase(_ => DatabaseLoader.Error(error)),
    )
    None
  })

  // Save progress whenever it changes
  React.useEffect1(() => {
    LocalStorage.saveProgress(userProgress)
    None
  }, [userProgress])

  let handleLessonSelect = (lessonId: int) => {
    // Always go to intro screen first for all lessons
    Router.push(LessonIntro(lessonId))
  }

  let handleStartReview = () => {
    Router.push(RandomReview)
  }

  let handleStartTimedChallenge = () => {
    Router.push(TimedChallenge)
  }

  let handleBackToList = () => {
    // Clear lesson 7 cache so it regenerates on next visit
    CangjieData.clearLesson7Cache()
    Router.push(LessonList)
  }

  let handleBackToHome = () => {
    Router.push(Home)
  }

  let handleUpdateProgress = (lessonId: int, accuracy: float, speed: float, completed: bool) => {
    // Check if this is the placement test
    if lessonId == 100 {
      // Save placement test results
      let recommendedLesson = if accuracy >= 0.90 && speed >= 30.0 {
        16 // Start with word lessons
      } else if accuracy >= 0.75 && speed >= 20.0 {
        10 // Continue with radicals group 4
      } else if accuracy >= 0.60 {
        7 // Continue with radicals group 3
      } else {
        1 // Start from beginning
      }

      setUserProgress(prev => {
        let updated = LocalStorage.updateLessonProgress(prev, lessonId, accuracy, speed, completed)
        {
          ...updated,
          placementTestTaken: true,
          placementResult: Some({
            accuracy: accuracy,
            speed: speed,
            recommendedLessonId: recommendedLesson,
            date: Js.Date.make(),
          }),
          currentLesson: recommendedLesson,
        }
      })
    } else if lessonId < 0 {
      // Dynamic lessons (negative IDs) - don't save progress
      ()
    } else {
      setUserProgress(prev => LocalStorage.updateLessonProgress(prev, lessonId, accuracy, speed, completed))
    }
  }

  let getDatabase = (): array<DatabaseLoader.dbEntry> => {
    switch database {
    | Loaded(db) => db
    | _ => []
    }
  }

  <div className="app">
    {switch database {
    | NotLoaded | Loading =>
      <div className="loading-screen">
        <h2> {React.string("載入資料庫...")} </h2>
        <p> {React.string("正在載入倉頡字典，請稍候")} </p>
      </div>

    | Error(message) =>
      <div className="error-screen">
        <h2> {React.string("載入失敗")} </h2>
        <p> {React.string(message)} </p>
        <p> {React.string("請重新整理頁面重試")} </p>
      </div>

    | Loaded(_) =>
      {switch currentRoute {
        | Router.Home =>
          <HomeView
            onStartLearning={() => Router.push(LessonList)}
            onPlacementTest={() => Router.push(LessonPractice(100))}
            onDictionary={() => Router.push(Dictionary)}
            onLessonGenerator={() => Router.push(LessonGenerator)}
            onReview={handleStartReview}
            onTimedChallenge={handleStartTimedChallenge}
            onSettings={() => Router.push(Settings)}
            userProgress={userProgress}
          />
        | Router.LessonList =>
          <LessonListView
            onLessonSelect={handleLessonSelect}
            onBack={handleBackToHome}
            userProgress={userProgress}
          />
        | Router.LessonIntro(lessonId) =>
          {switch CangjieData.getLessonById(lessonId) {
          | Some(lesson) =>
            // Use IntroductionMode for Introduction lessons, ReadyScreen for others
            if lesson.lessonType == Types.Introduction {
              <IntroductionMode
                lesson={lesson}
                onContinue={() => Router.push(LessonPractice(lessonId))}
                onBack={handleBackToList}
              />
            } else {
              <div className="lesson-view">
                <div className="lesson-header">
                  <button className="btn btn-back" onClick={_ => handleBackToList()}>
                    {React.string("← 返回")}
                  </button>
                  <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
                </div>
                <ReadyScreen
                  lesson={lesson}
                  onStart={() => Router.push(LessonPractice(lessonId))}
                />
              </div>
            }
          | None =>
            // Fallback to lesson 1
            <IntroductionMode
              lesson={CangjieData.getLessonById(1)->Belt.Option.getExn}
              onContinue={() => Router.push(LessonPractice(lessonId))}
              onBack={handleBackToList}
            />
          }}
        | Router.LessonPractice(lessonId) =>
          <LessonView
            lessonId={lessonId}
            onBack={handleBackToList}
            onUpdateProgress={handleUpdateProgress}
          />
        | Router.LessonComplete(lessonId) =>
          <CompletionView lessonId={lessonId} onBack={handleBackToList} />
        | Router.Dictionary =>
          <DictionaryView onBack={handleBackToHome} database={getDatabase()} />
        | Router.LessonGenerator =>
          <LessonGeneratorView
            onBack={handleBackToHome}
            onStartLesson={_ => {
              // For lesson generator, navigate to home
              Router.push(Home)
            }}
            database={getDatabase()}
          />
        | Router.RandomReview =>
          {switch CangjieData.createReviewLesson(userProgress.completedLessons, 20) {
          | Some(lesson) =>
            <DynamicLessonView
              lesson={lesson}
              onBack={handleBackToHome}
              onUpdateProgress={handleUpdateProgress}
            />
          | None =>
            <div className="error-screen">
              <h2> {React.string("無法創建複習")} </h2>
              <p> {React.string("請先完成一些課程")} </p>
              <button className="btn btn-primary" onClick={_ => Router.push(LessonList)}>
                {React.string("前往課程列表")}
              </button>
            </div>
          }}
        | Router.TimedChallenge =>
          {switch CangjieData.createTimedChallenge(userProgress.completedLessons, 60) {
          | Some(lesson) =>
            <DynamicLessonView
              lesson={lesson}
              onBack={handleBackToHome}
              onUpdateProgress={handleUpdateProgress}
            />
          | None =>
            <div className="error-screen">
              <h2> {React.string("無法創建挑戰")} </h2>
              <p> {React.string("請先完成一些課程")} </p>
              <button className="btn btn-primary" onClick={_ => Router.push(LessonList)}>
                {React.string("前往課程列表")}
              </button>
            </div>
          }}
        | Router.Settings =>
          <SettingsView onBack={handleBackToHome} />
        | Router.NotFound =>
          <div className="error-screen">
            <h2> {React.string("找不到頁面")} </h2>
            <p> {React.string("您訪問的頁面不存在")} </p>
            <button onClick={_ => Router.push(Home)}> {React.string("返回首頁")} </button>
          </div>
        }}
    }}
  </div>
}

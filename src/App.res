// Main App component

open Types

@react.component
let make = () => {
  let currentRoute = Router.useRoute()
  let (dynamicLesson, setDynamicLesson) = React.useState(() => None)
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
    Router.push(Lesson(lessonId))
  }

  let handleStartDynamicLesson = (lesson: lesson) => {
    setDynamicLesson(_ => Some(lesson))
    Router.push(Home) // Stay on home but show dynamic lesson
  }

  let handleStartReview = () => {
    switch CangjieData.createReviewLesson(userProgress.completedLessons, 20) {
    | Some(lesson) => handleStartDynamicLesson(lesson)
    | None => ()
    }
  }

  let handleStartTimedChallenge = () => {
    switch CangjieData.createTimedChallenge(userProgress.completedLessons, 60) {
    | Some(lesson) => handleStartDynamicLesson(lesson)
    | None => ()
    }
  }

  let handleBackToList = () => {
    Router.push(LessonList)
  }

  let handleBackToHome = () => {
    setDynamicLesson(_ => None) // Clear dynamic lesson
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
      {switch dynamicLesson {
      | Some(lesson) =>
        <DynamicLessonView
          lesson={lesson}
          onBack={handleBackToHome}
          onUpdateProgress={handleUpdateProgress}
        />
      | None =>
        switch currentRoute {
        | Router.Home =>
          <HomeView
            onStartLearning={() => Router.push(LessonList)}
            onPlacementTest={() => Router.push(Lesson(100))}
            onDictionary={() => Router.push(Dictionary)}
            onLessonGenerator={() => Router.push(LessonGenerator)}
            onReview={handleStartReview}
            onTimedChallenge={handleStartTimedChallenge}
            userProgress={userProgress}
          />
        | Router.LessonList =>
          <LessonListView
            onLessonSelect={handleLessonSelect}
            onBack={handleBackToHome}
            userProgress={userProgress}
          />
        | Router.Lesson(lessonId) =>
          <LessonView
            lessonId={lessonId}
            onBack={handleBackToList}
            onUpdateProgress={handleUpdateProgress}
          />
        | Router.Dictionary =>
          <DictionaryView onBack={handleBackToHome} database={getDatabase()} />
        | Router.LessonGenerator =>
          <LessonGeneratorView
            onBack={handleBackToHome}
            onStartLesson={handleStartDynamicLesson}
            database={getDatabase()}
          />
        | Router.NotFound =>
          <div className="error-screen">
            <h2> {React.string("找不到頁面")} </h2>
            <p> {React.string("您訪問的頁面不存在")} </p>
            <button onClick={_ => Router.push(Home)}> {React.string("返回首頁")} </button>
          </div>
        }
      }}
    }}
  </div>
}

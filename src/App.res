// Main App component

open Types

type view =
  | Home
  | LessonList
  | LessonView(int)
  | DynamicLessonView(lesson)
  | Dictionary
  | LessonGenerator

@react.component
let make = () => {
  let (currentView, setCurrentView) = React.useState(() => Home)
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
    setCurrentView(_ => LessonView(lessonId))
  }

  let handleStartDynamicLesson = (lesson: lesson) => {
    setCurrentView(_ => DynamicLessonView(lesson))
  }

  let handleBackToList = () => {
    setCurrentView(_ => LessonList)
  }

  let handleBackToHome = () => {
    setCurrentView(_ => Home)
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
      {switch currentView {
      | Home =>
        <HomeView
          onStartLearning={() => setCurrentView(_ => LessonList)}
          onPlacementTest={() => setCurrentView(_ => LessonView(100))}
          onDictionary={() => setCurrentView(_ => Dictionary)}
          onLessonGenerator={() => setCurrentView(_ => LessonGenerator)}
          userProgress={userProgress}
        />
      | LessonList =>
        <LessonListView
          onLessonSelect={handleLessonSelect}
          onBack={handleBackToHome}
          userProgress={userProgress}
        />
      | LessonView(lessonId) =>
        <LessonView
          lessonId={lessonId}
          onBack={handleBackToList}
          onUpdateProgress={handleUpdateProgress}
        />
      | DynamicLessonView(lesson) =>
        <DynamicLessonView
          lesson={lesson}
          onBack={handleBackToHome}
          onUpdateProgress={handleUpdateProgress}
        />
      | Dictionary =>
        <DictionaryView onBack={handleBackToHome} database={getDatabase()} />
      | LessonGenerator =>
        <LessonGeneratorView
          onBack={handleBackToHome}
          onStartLesson={handleStartDynamicLesson}
          database={getDatabase()}
        />
      }}
    }}
  </div>
}

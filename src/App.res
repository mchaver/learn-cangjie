// Main App component

open Types

type view =
  | Home
  | LessonList
  | LessonView(int)

@react.component
let make = () => {
  let (currentView, setCurrentView) = React.useState(() => Home)
  let (userProgress, setUserProgress) = React.useState(() => LocalStorage.loadProgress())

  // Save progress whenever it changes
  React.useEffect1(() => {
    LocalStorage.saveProgress(userProgress)
    None
  }, [userProgress])

  let handleLessonSelect = (lessonId: int) => {
    setCurrentView(_ => LessonView(lessonId))
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
    } else {
      setUserProgress(prev => LocalStorage.updateLessonProgress(prev, lessonId, accuracy, speed, completed))
    }
  }

  <div className="app">
    {switch currentView {
    | Home =>
      <HomeView
        onStartLearning={() => setCurrentView(_ => LessonList)}
        onPlacementTest={() => setCurrentView(_ => LessonView(100))}
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
        userProgress={userProgress}
      />
    }}
  </div>
}

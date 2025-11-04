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
    setUserProgress(prev => LocalStorage.updateLessonProgress(prev, lessonId, accuracy, speed, completed))
  }

  <div className="app">
    {switch currentView {
    | Home =>
      <HomeView
        onStartLearning={() => setCurrentView(_ => LessonList)}
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

// Main lesson view component - handles practice and test modes

open Types

@react.component
let make = (
  ~lessonId: int,
  ~onBack: unit => unit,
  ~onUpdateProgress: (int, float, float, bool) => unit,
) => {
  let lesson = CangjieData.getLessonById(lessonId)
  let (inputState, setInputState) = React.useState(() => (
    {
      currentIndex: 0,
      currentInput: "",
      stats: {
        totalCharacters: 0,
        correctCharacters: 0,
        incorrectCharacters: 0,
        startTime: Js.Date.now(),
        endTime: None,
      },
      errors: [],
    }: inputState
  ))

  let handleComplete = () => {
    // Calculate final stats
    let endTime = Js.Date.now()
    let duration = endTime -. inputState.stats.startTime
    let accuracy = CangjieUtils.calculateAccuracy(
      inputState.stats.correctCharacters,
      inputState.stats.totalCharacters,
    )
    let speed = CangjieUtils.calculateCPM(inputState.stats.correctCharacters, duration)

    // Determine if lesson is completed based on target
    let isCompleted = switch lesson {
    | Some(l) => accuracy >= l.targetAccuracy
    | None => false
    }

    // Update progress
    onUpdateProgress(lessonId, accuracy, speed, isCompleted)

    // Save completion stats and navigate to completion page
    LocalStorage.saveCompletionStats(lessonId, inputState)
    Router.push(LessonComplete(lessonId))
  }


  switch lesson {
  | None =>
    <div className="lesson-view">
      <div className="lesson-header">
        <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
      </div>
      <div className="error-message"> {React.string("找不到此課程")} </div>
    </div>

  | Some(lesson) =>
    <div className="lesson-view">
      <div className="lesson-header">
        <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
        <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
      </div>

      {switch lesson.lessonType {
      | Types.Practice | Types.Review | Types.MixedReview | Types.Introduction =>
        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | Types.Test | Types.PlacementTest =>
        <TestMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | Types.TimedChallenge =>
        <TimedChallengeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
          durationSeconds={60}
        />
      }}
    </div>
  }
}

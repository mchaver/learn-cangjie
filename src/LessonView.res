// Main lesson view component - handles intro, practice, and test modes

open Types

type lessonState =
  | Introduction
  | Ready
  | Active
  | Completed

@react.component
let make = (
  ~lessonId: int,
  ~onBack: unit => unit,
  ~onUpdateProgress: (int, float, float, bool) => unit,
) => {
  let lesson = CangjieData.getLessonById(lessonId)
  let (state, setState) = React.useState(() => Introduction)
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

  // Skip ready screen for non-Introduction lessons
  React.useEffect1(() => {
    switch lesson {
    | Some(l) =>
      if l.lessonType != Types.Introduction && state == Introduction {
        setState(_ => Active)
      }
    | None => ()
    }
    None
  }, [state])

  let handleStart = () => {
    setInputState(_ => {
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
      }
    })
    setState(_ => Active)
  }

  let handleComplete = () => {
    setState(_ => Completed)

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

    onUpdateProgress(lessonId, accuracy, speed, isCompleted)
  }

  let handleRestart = () => {
    setState(_ => Ready)
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

      {switch (lesson.lessonType, state) {
      | (Types.Introduction, Introduction) =>
        <IntroductionMode lesson={lesson} onContinue={handleStart} />
      | (_, Introduction) | (_, Ready) =>
        <ReadyScreen lesson={lesson} onStart={handleStart} />
      | (Types.Practice, Active) =>
        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | (Types.Test, Active) =>
        <TestMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | (_, Active) =>
        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | (_, Completed) =>
        <CompletionScreen
          lesson={lesson}
          inputState={inputState}
          onRestart={handleRestart}
          onBack={onBack}
        />
      }}
    </div>
  }
}

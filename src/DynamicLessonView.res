// Dynamic lesson view - for lessons generated at runtime

open Types

type lessonState =
  | Ready
  | Active
  | Completed

@react.component
let make = (
  ~lesson: lesson,
  ~onBack: unit => unit,
  ~onUpdateProgress: (int, float, float, bool) => unit,
) => {
  let (state, setState) = React.useState(() => Ready)
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

  let handleStart = () => {
    setInputState(_ => (
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
    ))
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

    // Update progress (dynamic lessons have negative IDs, won't be saved)
    onUpdateProgress(lesson.id, accuracy, speed, false)
  }

  let handleRestart = () => {
    setState(_ => Ready)
  }

  <div className="lesson-view">
    <div className="lesson-header">
      <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
      <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
    </div>

    {switch state {
    | Ready =>
      <ReadyScreen lesson={lesson} onStart={handleStart} />
    | Active =>
      switch lesson.lessonType {
      | Practice =>
        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | Test | _ =>
        <TestMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      }
    | Completed =>
      <CompletionScreen
        lesson={lesson}
        inputState={inputState}
        onRestart={handleRestart}
        onBack={onBack}
      />
    }}
  </div>
}

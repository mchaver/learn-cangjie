// Dynamic lesson view - for lessons generated at runtime

open Types

type lessonState =
  | Ready
  | Active
  | Completed
  | RetryingErrors

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
  let (completedInputState, setCompletedInputState) = React.useState(() => None)
  let (retryInputState, setRetryInputState) = React.useState(() => None)
  let (retryLesson, setRetryLesson) = React.useState(() => None)

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
    // Save the completed input state
    setCompletedInputState(_ => Some(inputState))
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

  let handleRetryErrors = () => {
    switch completedInputState {
    | Some(completed) =>
      // Extract unique character indices that had errors and shuffle them
      let errorIndices = completed.errors
        ->Js.Array2.map(((idx, _)) => idx)
        ->Belt.Set.Int.fromArray
        ->Belt.Set.Int.toArray

      // Shuffle the error indices
      let shuffledIndices = {
        let arr = errorIndices->Js.Array2.copy
        // Fisher-Yates shuffle
        let length = arr->Js.Array2.length
        for i in 0 to length - 2 {
          let j = i + Js.Math.random_int(i, length)
          let temp = Belt.Array.getUnsafe(arr, i)
          Belt.Array.setUnsafe(arr, i, Belt.Array.getUnsafe(arr, j))
          Belt.Array.setUnsafe(arr, j, temp)
        }
        arr
      }

      // Create retry lesson with shuffled error characters
      let newRetryLesson = {
        ...lesson,
        title: `${lesson.title} - 錯誤字練習`,
        characters: shuffledIndices
          ->Js.Array2.map(idx => lesson.characters[idx])
          ->Js.Array2.filter(Belt.Option.isSome)
          ->Js.Array2.map(Belt.Option.getExn),
        allowHints: true,
        allowGiveUp: false,
        showCode: false,
      }

      setRetryLesson(_ => Some(newRetryLesson))

      // Initialize retry input state
      setRetryInputState(_ => Some({
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
      }))
      setState(_ => RetryingErrors)
    | None => ()
    }
  }

  let handleRetryComplete = () => {
    setState(_ => Completed)
    setRetryInputState(_ => None)
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
      | Practice | Review | MixedReview =>
        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      | Test | TimedChallenge | _ =>
        <TestMode
          lesson={lesson}
          inputState={inputState}
          setInputState={setInputState}
          onComplete={handleComplete}
        />
      }
    | RetryingErrors =>
      switch (retryLesson, retryInputState) {
      | (Some(lesson), Some(retry)) =>
        <PracticeMode
          lesson={lesson}
          inputState={retry}
          setInputState={updater => setRetryInputState(_ => Some(updater(retry)))}
          onComplete={handleRetryComplete}
        />
      | _ => React.null
      }
    | Completed =>
      switch completedInputState {
      | Some(completed) =>
        <CompletionScreen
          lesson={lesson}
          inputState={completed}
          onRestart={handleRestart}
          onBack={onBack}
          onRetryErrors=?{Some(handleRetryErrors)}
        />
      | None =>
        <CompletionScreen
          lesson={lesson}
          inputState={inputState}
          onRestart={handleRestart}
          onBack={onBack}
          onRetryErrors=?{Some(handleRetryErrors)}
        />
      }
    }}
  </div>
}

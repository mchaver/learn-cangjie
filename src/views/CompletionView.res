// Completion view - standalone page showing results after finishing a lesson

open Types

type retryState =
  | ShowingResults
  | RetryingErrors

@react.component
let make = (~lessonId: int, ~onBack: unit => unit) => {
  // Load completion stats from localStorage
  let completionData = LocalStorage.loadCompletionStats()

  // Get lesson data
  let lesson = CangjieData.getLessonById(lessonId)

  // Track retry state
  let (state, setState) = React.useState(() => ShowingResults)
  let (retryInputState, setRetryInputState) = React.useState(() => None)
  let (retryLesson, setRetryLesson) = React.useState(() => None)

  // Clear completion stats when component unmounts
  React.useEffect0(() => {
    Some(() => LocalStorage.clearCompletionStats())
  })

  let handleRestart = () => {
    Router.push(LessonPractice(lessonId))
  }

  let handleNextLesson = () => {
    // Find next lesson
    let nextLessonId = lessonId + 1
    let nextLesson = CangjieData.getLessonById(nextLessonId)
    switch nextLesson {
    | Some(_) => Router.push(LessonIntro(nextLessonId))
    | None => onBack()
    }
  }

  let handleRetryErrors = (lesson: lesson, inputState: inputState) => {
    // Extract unique character indices that had errors and shuffle them
    let errorIndices = inputState.errors
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

    // Create initial retry input state
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
  }

  let handleRetryComplete = () => {
    setState(_ => ShowingResults)
    setRetryInputState(_ => None)
  }

  switch (lesson, completionData, state) {
  | (None, _, _) | (_, None, _) =>
    <div className="lesson-view">
      <div className="lesson-header">
        <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
      </div>
      <div className="error-message"> {React.string("找不到課程資料")} </div>
    </div>

  | (Some(_lesson), Some((_lessonId, _inputState)), RetryingErrors) =>
    switch (retryLesson, retryInputState) {
    | (Some(lesson), Some(inputState)) =>
      <div className="lesson-view">
        <div className="lesson-header">
          <button className="btn btn-back" onClick={_ => handleRetryComplete()}>
            {React.string("← 返回結果")}
          </button>
          <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
        </div>

        <PracticeMode
          lesson={lesson}
          inputState={inputState}
          setInputState={updater => setRetryInputState(prev => prev->Belt.Option.map(updater))}
          onComplete={handleRetryComplete}
        />
      </div>
    | _ => React.null
    }

  | (Some(lesson), Some((_, inputState)), ShowingResults) =>
    let duration = Js.Date.now() -. inputState.stats.startTime
    let accuracy = CangjieUtils.calculateAccuracy(
      inputState.stats.correctCharacters,
      inputState.stats.totalCharacters,
    )
    let speed = CangjieUtils.calculateCPM(inputState.stats.correctCharacters, duration)
    let passed = accuracy >= lesson.targetAccuracy

    <div className="lesson-view">
      <div className="lesson-header">
        <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
        <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
      </div>

      <div className="completion-screen">
        <div className="completion-content">
          <div className={`completion-status ${passed ? "passed" : "failed"}`}>
            {passed
              ? <>
                  <div className="status-icon"> {React.string("✓")} </div>
                  <h2> {React.string("恭喜！課程完成")} </h2>
                </>
              : <>
                  <div className="status-icon"> {React.string("✗")} </div>
                  <h2> {React.string("繼續努力！")} </h2>
                </>}
          </div>

          <div className="completion-stats">
            <div className="stat-card">
              <div className="stat-label"> {React.string("準確率")} </div>
              <div className={`stat-value ${accuracy >= lesson.targetAccuracy ? "good" : "needs-improvement"}`}>
                {React.string(`${Js.Float.toFixedWithPrecision(accuracy *. 100.0, ~digits=1)}%`)}
              </div>
              <div className="stat-target">
                {React.string(`目標: ${Js.Float.toFixedWithPrecision(lesson.targetAccuracy *. 100.0, ~digits=0)}%`)}
              </div>
            </div>

            <div className="stat-card">
              <div className="stat-label"> {React.string("打字速度")} </div>
              <div className="stat-value">
                {React.string(`${Js.Float.toFixedWithPrecision(speed, ~digits=1)}`)}
              </div>
              <div className="stat-unit"> {React.string("字/分鐘")} </div>
              {switch lesson.targetSpeed {
              | Some(targetSpeed) =>
                <div className="stat-target">
                  {React.string(`目標: ${Js.Float.toFixedWithPrecision(targetSpeed, ~digits=0)} 字/分`)}
                </div>
              | None => React.null
              }}
            </div>

            <div className="stat-card">
              <div className="stat-label"> {React.string("總字符數")} </div>
              <div className="stat-value">
                {React.string(Belt.Int.toString(inputState.stats.totalCharacters))}
              </div>
            </div>

            <div className="stat-card">
              <div className="stat-label"> {React.string("錯誤次數")} </div>
              <div className="stat-value">
                {React.string(Belt.Int.toString(inputState.stats.incorrectCharacters))}
              </div>
            </div>

            <div className="stat-card">
              <div className="stat-label"> {React.string("用時")} </div>
              <div className="stat-value">
                {React.string(`${Js.Float.toFixedWithPrecision(duration /. 1000.0, ~digits=1)}秒`)}
              </div>
            </div>
          </div>

          {inputState.errors->Js.Array2.length > 0
            ? <div className="completion-errors">
                <h3> {React.string("錯誤記錄")} </h3>
                <div className="errors-list">
                  {inputState.errors
                  ->Js.Array2.slice(~start=0, ~end_=5)
                  ->Js.Array2.map(((charIndex, wrongInput)) => {
                    let charInfo = lesson.characters->Belt.Array.get(charIndex)
                    switch charInfo {
                    | Some(info) =>
                      <div key={Belt.Int.toString(charIndex)} className="error-item">
                        <span className="error-char"> {React.string(info.character)} </span>
                        <span className="error-input"> {React.string(`輸入: ${wrongInput}`)} </span>
                        <span className="error-correct">
                          {React.string(`正確: ${CangjieUtils.keysToCode(info.cangjieCode)}`)}
                        </span>
                      </div>
                    | None => React.null
                    }
                  })
                  ->React.array}
                </div>
                {inputState.errors->Js.Array2.length > 5
                  ? <div className="errors-more">
                      {React.string(
                        `還有 ${Belt.Int.toString(inputState.errors->Js.Array2.length - 5)} 個錯誤...`,
                      )}
                    </div>
                  : React.null}
              </div>
            : React.null}

          <div className="completion-actions">
            <button className="btn btn-secondary" onClick={_ => handleRestart()}>
              {React.string("重新練習")}
            </button>
            {inputState.errors->Js.Array2.length > 0
              ? <button className="btn btn-warning" onClick={_ => handleRetryErrors(lesson, inputState)}>
                  {React.string("練習錯誤的字")}
                </button>
              : React.null}
            <button className="btn btn-primary" onClick={_ => onBack()}>
              {React.string("返回課程列表")}
            </button>
            <button className={passed ? "btn btn-primary" : "btn btn-warning"} onClick={_ => handleNextLesson()}>
              {React.string("下一課")}
            </button>
          </div>
        </div>
      </div>
    </div>
  }
}

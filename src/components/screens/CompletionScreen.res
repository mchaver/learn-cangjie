// Completion screen - shows results after finishing a lesson

open Types

@react.component
let make = (
  ~lesson: lesson,
  ~inputState: inputState,
  ~onRestart: unit => unit,
  ~onBack: unit => unit,
  ~onNext: option<unit => unit>=?,
) => {
  let duration = Js.Date.now() -. inputState.stats.startTime
  let accuracy = CangjieUtils.calculateAccuracy(
    inputState.stats.correctCharacters,
    inputState.stats.totalCharacters,
  )
  let speed = CangjieUtils.calculateCPM(inputState.stats.correctCharacters, duration)

  let passed = accuracy >= lesson.targetAccuracy

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
        <button className="btn btn-secondary" onClick={_ => onRestart()}>
          {React.string("重新練習")}
        </button>
        <button className="btn btn-primary" onClick={_ => onBack()}>
          {React.string("返回課程列表")}
        </button>
        {switch onNext {
        | Some(nextHandler) =>
          <button className={passed ? "btn btn-primary" : "btn btn-warning"} onClick={_ => nextHandler()}>
            {React.string("下一課")}
          </button>
        | None => React.null
        }}
      </div>
    </div>
  </div>
}

// Ready screen - shown before starting practice/test

open Types

@react.component
let make = (~lesson: lesson, ~onStart: unit => unit) => {
  let modeText = switch lesson.lessonType {
  | Introduction => "學習"
  | Practice => "練習"
  | Test => "測驗"
  | Review => "複習"
  | MixedReview => "綜合練習"
  | TimedChallenge => "限時挑戰"
  | PlacementTest => "程度測驗"
  }

  <div className="ready-screen">
    <div className="ready-content">
      <h2> {React.string(`準備開始${modeText}`)} </h2>
      <p className="ready-description"> {React.string(lesson.description)} </p>

      <div className="ready-info">
        <div className="info-item">
          <div className="info-label"> {React.string("字符數量")} </div>
          <div className="info-value">
            {React.string(Belt.Int.toString(lesson.characters->Js.Array2.length))}
          </div>
        </div>

        {switch lesson.targetAccuracy {
        | accuracy if accuracy > 0.0 =>
          <div className="info-item">
            <div className="info-label"> {React.string("目標準確率")} </div>
            <div className="info-value">
              {React.string(`${Js.Float.toFixedWithPrecision(accuracy *. 100.0, ~digits=0)}%`)}
            </div>
          </div>
        | _ => React.null
        }}

        {switch lesson.targetSpeed {
        | Some(speed) =>
          <div className="info-item">
            <div className="info-label"> {React.string("目標速度")} </div>
            <div className="info-value"> {React.string(`${Js.Float.toFixedWithPrecision(speed, ~digits=0)} 字/分鐘`)} </div>
          </div>
        | None => React.null
        }}
      </div>

      <div className="ready-instructions">
        {switch lesson.lessonType {
        | Practice =>
          <>
            <h3> {React.string("練習模式說明")} </h3>
            <ul>
              <li> {React.string("將鼠標懸停在字符上可查看倉頡碼提示")} </li>
              <li> {React.string("輸入正確的倉頡碼以繼續下一個字符")} </li>
              <li> {React.string("沒有時間限制，專注於準確性")} </li>
            </ul>
          </>
        | Test =>
          <>
            <h3> {React.string("測驗模式說明")} </h3>
            <ul>
              <li> {React.string("將記錄您的打字速度和準確率")} </li>
              <li> {React.string("沒有提示，測試您的記憶能力")} </li>
              <li> {React.string("達到目標準確率即可通過測驗")} </li>
            </ul>
          </>
        | Review =>
          <>
            <h3> {React.string("複習模式說明")} </h3>
            <ul>
              <li> {React.string("隨機複習已學過的字符")} </li>
              <li> {React.string("可以懸停查看提示")} </li>
              <li> {React.string("鞏固您的記憶")} </li>
            </ul>
          </>
        | MixedReview =>
          <>
            <h3> {React.string("綜合練習說明")} </h3>
            <ul>
              <li> {React.string("綜合測試：基礎字符 + 應用詞彙")} </li>
              <li> {React.string("隨機順序，全面檢驗學習成果")} </li>
              <li> {React.string("無提示模式，挑戰記憶能力")} </li>
            </ul>
          </>
        | TimedChallenge =>
          <>
            <h3> {React.string("限時挑戰說明")} </h3>
            <ul>
              <li> {React.string("在限定時間內盡可能打出更多字")} </li>
              <li> {React.string("錯誤答案不會中斷，但會影響準確率")} </li>
              <li> {React.string("挑戰您的速度極限！")} </li>
            </ul>
          </>
        | _ => React.null
        }}
      </div>

      <div className="ready-actions">
        <button className="btn btn-primary btn-large" onClick={_ => onStart()}>
          {React.string(`開始${modeText}`)}
        </button>
      </div>
    </div>
  </div>
}

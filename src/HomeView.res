// Home view component

open Types

@react.component
let make = (~onStartLearning: unit => unit, ~userProgress: userProgress) => {
  let completedCount = userProgress.completedLessons->Js.Array2.length
  let totalLessons = CangjieData.getAllLessons()->Js.Array2.length

  <div className="home-view">
    <div className="home-content">
      <h1 className="app-title"> {React.string("學習倉頡輸入法")} </h1>
      <p className="app-subtitle"> {React.string("Learn Cangjie Input Method")} </p>

      <div className="home-stats">
        <div className="stat-item">
          <div className="stat-label"> {React.string("已完成課程")} </div>
          <div className="stat-value">
            {React.string(`${Belt.Int.toString(completedCount)} / ${Belt.Int.toString(totalLessons)}`)}
          </div>
        </div>
      </div>

      <div className="home-actions">
        <button className="btn btn-primary btn-large" onClick={_ => onStartLearning()}>
          {React.string(if completedCount > 0 {
            "繼續學習"
          } else {
            "開始學習"
          })}
        </button>
      </div>

      <div className="home-info">
        <h2> {React.string("關於倉頡輸入法")} </h2>
        <p>
          {React.string(
            "倉頡輸入法是一種常用的中文輸入法，使用字根將漢字分解並編碼。本應用程式將幫助您循序漸進地學習倉頡輸入法的基礎知識。",
          )}
        </p>
        <div className="features">
          <div className="feature-item">
            <h3> {React.string("📚 系統化學習")} </h3>
            <p> {React.string("從基礎字根開始，逐步學習所有倉頡字根")} </p>
          </div>
          <div className="feature-item">
            <h3> {React.string("✍️ 實踐練習")} </h3>
            <p> {React.string("通過練習模式熟悉字根組合")} </p>
          </div>
          <div className="feature-item">
            <h3> {React.string("📊 追蹤進度")} </h3>
            <p> {React.string("記錄您的準確率和打字速度")} </p>
          </div>
        </div>
      </div>
    </div>
  </div>
}

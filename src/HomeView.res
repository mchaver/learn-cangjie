// Home view component

open Types

@react.component
let make = (
  ~onStartLearning: unit => unit,
  ~onPlacementTest: unit => unit,
  ~onDictionary: unit => unit,
  ~onLessonGenerator: unit => unit,
  ~userProgress: userProgress,
) => {
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
        {switch userProgress.placementResult {
        | Some(result) =>
          <>
            <div className="stat-item">
              <div className="stat-label"> {React.string("程度測驗準確率")} </div>
              <div className="stat-value">
                {React.string(`${Js.Float.toFixedWithPrecision(result.accuracy *. 100.0, ~digits=1)}%`)}
              </div>
            </div>
            <div className="stat-item">
              <div className="stat-label"> {React.string("程度測驗速度")} </div>
              <div className="stat-value">
                {React.string(`${Js.Float.toFixedWithPrecision(result.speed, ~digits=1)} 字/分`)}
              </div>
            </div>
          </>
        | None => React.null
        }}
      </div>

      <div className="home-actions">
        <button className="btn btn-primary btn-large" onClick={_ => onStartLearning()}>
          {React.string(if completedCount > 0 {
            "繼續學習"
          } else {
            "開始學習"
          })}
        </button>
        {!userProgress.placementTestTaken
          ? <button className="btn btn-secondary btn-large" onClick={_ => onPlacementTest()}>
              {React.string("程度測驗")}
            </button>
          : React.null}
      </div>

      <div className="home-tools">
        <h2> {React.string("工具與功能")} </h2>
        <div className="tools-grid">
          <button className="tool-card" onClick={_ => onDictionary()}>
            <h3> {React.string("倉頡字典")} </h3>
            <p> {React.string("查詢漢字的倉頡碼或根據倉頡碼查字")} </p>
          </button>
          <button className="tool-card" onClick={_ => onLessonGenerator()}>
            <h3> {React.string("自訂練習")} </h3>
            <p> {React.string("輸入任何文字或按難度生成練習課程")} </p>
          </button>
        </div>
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
            <h3> {React.string("系統化學習")} </h3>
            <p> {React.string("從基礎字根開始，逐步學習所有倉頡字根")} </p>
          </div>
          <div className="feature-item">
            <h3> {React.string("實踐練習")} </h3>
            <p> {React.string("通過練習模式熟悉字根組合")} </p>
          </div>
          <div className="feature-item">
            <h3> {React.string("追蹤進度")} </h3>
            <p> {React.string("記錄您的準確率和打字速度")} </p>
          </div>
          <div className="feature-item">
            <h3> {React.string("字典查詢")} </h3>
            <p> {React.string("68,000+ 字符的完整倉頡資料庫")} </p>
          </div>
        </div>
      </div>
    </div>
  </div>
}

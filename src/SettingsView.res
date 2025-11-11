// Settings view component

open Types

@react.component
let make = (~onBack: unit => unit) => {
  // Get current setting
  let (currentMode, setCurrentMode) = React.useState(() => LocalStorage.getPracticeRepeatMode())

  // Handle mode change
  let handleModeChange = (mode: practiceRepeatMode) => {
    setCurrentMode(_ => mode)
    LocalStorage.setPracticeRepeatMode(mode)
  }

  <div className="settings-view">
    <div className="settings-content">
      <h1 className="settings-title"> {React.string("設定")} </h1>
      <p className="settings-subtitle"> {React.string("Settings")} </p>

      <div className="settings-section">
        <h2 className="settings-section-title"> {React.string("三次練習模式")} </h2>
        <p className="settings-section-description">
          {React.string("控制多鍵字元首次出現時的「三次練習」功能")}
        </p>

        <div className="settings-options">
          // Option 1: Never
          <div
            className={currentMode == Never ? "settings-option settings-option-active" : "settings-option"}
            onClick={_ => handleModeChange(Never)}>
            <div className="settings-option-radio">
              {currentMode == Never
                ? <div className="settings-option-radio-dot" />
                : React.null}
            </div>
            <div className="settings-option-content">
              <div className="settings-option-title"> {React.string("從不顯示")} </div>
              <div className="settings-option-description">
                {React.string("完全關閉三次練習功能，所有字元都只練習一次")}
              </div>
            </div>
          </div>

          // Option 2: Earliest Lesson (DEFAULT)
          <div
            className={currentMode == EarliestLesson ? "settings-option settings-option-active" : "settings-option"}
            onClick={_ => handleModeChange(EarliestLesson)}>
            <div className="settings-option-radio">
              {currentMode == EarliestLesson
                ? <div className="settings-option-radio-dot" />
                : React.null}
            </div>
            <div className="settings-option-content">
              <div className="settings-option-title">
                {React.string("僅在最早課程顯示")}
                <span className="settings-option-badge"> {React.string("建議")} </span>
              </div>
              <div className="settings-option-description">
                {React.string("字元首次出現的最早課程中進行三次練習，其他課程只練習一次")}
              </div>
            </div>
          </div>

          // Option 3: Any Lesson
          <div
            className={currentMode == AnyLesson ? "settings-option settings-option-active" : "settings-option"}
            onClick={_ => handleModeChange(AnyLesson)}>
            <div className="settings-option-radio">
              {currentMode == AnyLesson
                ? <div className="settings-option-radio-dot" />
                : React.null}
            </div>
            <div className="settings-option-content">
              <div className="settings-option-title"> {React.string("每課首次顯示")} </div>
              <div className="settings-option-description">
                {React.string("每個課程中字元首次出現時都進行三次練習")}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="settings-actions">
        <button className="btn btn-secondary" onClick={_ => onBack()}>
          {React.string("返回")}
        </button>
      </div>
    </div>
  </div>
}

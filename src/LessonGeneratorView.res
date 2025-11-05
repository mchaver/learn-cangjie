// Lesson Generator view - create custom lessons dynamically

open Types

type generatorMode =
  | CustomText
  | ByDifficulty

@react.component
let make = (
  ~onBack: unit => unit,
  ~onStartLesson: lesson => unit,
  ~database: array<DatabaseLoader.dbEntry>,
) => {
  let (mode, setMode) = React.useState(() => CustomText)
  let (customText, setCustomText) = React.useState(() => "")
  let (difficulty, setDifficulty) = React.useState(() => "basic")
  let (characterCount, setCharacterCount) = React.useState(() => "15")
  let (lessonType, setLessonType) = React.useState(() => Practice)

  let handleGenerate = () => {
    let lesson = switch mode {
    | CustomText =>
      if customText->Js.String2.trim == "" {
        None
      } else {
        DatabaseLoader.generateLessonFromText(
          database,
          customText,
          "自訂練習",
          `練習您選擇的文字：${customText->Js.String2.slice(~from=0, ~to_=20)}...`,
          lessonType,
        )
      }
    | ByDifficulty => {
        let count = Belt.Int.fromString(characterCount)->Belt.Option.getWithDefault(15)
        DatabaseLoader.generateLessonByDifficulty(database, difficulty, count, lessonType)
      }
    }

    switch lesson {
    | Some(l) => onStartLesson(l)
    | None => Js.log("Failed to generate lesson")
    }
  }

  <div className="lesson-generator-view">
    <div className="generator-header">
      <button className="btn btn-back" onClick={_ => onBack()}>
        {React.string("← 返回")}
      </button>
      <h1> {React.string("自訂課程")} </h1>
    </div>

    <div className="generator-content">
      <div className="generator-mode-selector">
        <button
          className={`btn ${mode == CustomText ? "btn-primary" : "btn-secondary"}`}
          onClick={_ => setMode(_ => CustomText)}>
          {React.string("自訂文字")}
        </button>
        <button
          className={`btn ${mode == ByDifficulty ? "btn-primary" : "btn-secondary"}`}
          onClick={_ => setMode(_ => ByDifficulty)}>
          {React.string("按難度練習")}
        </button>
      </div>

      <div className="generator-options">
        {switch mode {
        | CustomText =>
          <div className="custom-text-options">
            <h3> {React.string("輸入練習文字")} </h3>
            <p className="option-description">
              {React.string("輸入任何繁體中文文字，我們會為您生成練習課程")}
            </p>
            <textarea
              className="custom-text-input"
              placeholder="例如：學習倉頡輸入法可以提高打字速度。"
              value={customText}
              rows={6}
              onChange={e => {
                let value = ReactEvent.Form.target(e)["value"]
                setCustomText(_ => value)
              }}
            />
            <div className="text-info">
              {React.string(
                `字數：${Belt.Int.toString(customText->Js.String2.length)}`,
              )}
            </div>
          </div>

        | ByDifficulty =>
          <div className="difficulty-options">
            <h3> {React.string("選擇難度")} </h3>
            <p className="option-description">
              {React.string("根據倉頡碼的長度來選擇練習難度")}
            </p>

            <div className="form-group">
              <label> {React.string("難度級別：")} </label>
              <select
                className="form-select"
                value={difficulty}
                onChange={e => {
                  let value = ReactEvent.Form.target(e)["value"]
                  setDifficulty(_ => value)
                }}>
                <option value="easy"> {React.string("簡單（1字根）")} </option>
                <option value="basic"> {React.string("基礎（2字根）")} </option>
                <option value="medium"> {React.string("中等（3字根）")} </option>
                <option value="hard"> {React.string("困難（4字根）")} </option>
                <option value="veryhard"> {React.string("極難（5字根）")} </option>
              </select>
            </div>

            <div className="form-group">
              <label> {React.string("練習字數：")} </label>
              <select
                className="form-select"
                value={characterCount}
                onChange={e => {
                  let value = ReactEvent.Form.target(e)["value"]
                  setCharacterCount(_ => value)
                }}>
                <option value="10"> {React.string("10 個字")} </option>
                <option value="15"> {React.string("15 個字")} </option>
                <option value="20"> {React.string("20 個字")} </option>
                <option value="30"> {React.string("30 個字")} </option>
                <option value="50"> {React.string("50 個字")} </option>
              </select>
            </div>

            <div className="difficulty-info">
              <h4> {React.string("難度說明：")} </h4>
              <ul>
                <li> {React.string("簡單：單一字根字符，適合初學者")} </li>
                <li> {React.string("基礎：兩個字根，掌握基本組合")} </li>
                <li> {React.string("中等：三個字根，常見複雜字")} </li>
                <li> {React.string("困難：四個字根，需要熟練掌握")} </li>
                <li> {React.string("極難：五個或更多字根，挑戰高手")} </li>
              </ul>
            </div>
          </div>
        }}

        <div className="lesson-type-selector">
          <h3> {React.string("練習模式：")} </h3>
          <div className="radio-group">
            <label className="radio-label">
              <input
                type_="radio"
                checked={lessonType == Practice}
                onChange={_ => setLessonType(_ => Practice)}
              />
              {React.string(" 練習模式（可查看提示）")}
            </label>
            <label className="radio-label">
              <input
                type_="radio"
                checked={lessonType == Test}
                onChange={_ => setLessonType(_ => Test)}
              />
              {React.string(" 測驗模式（無提示）")}
            </label>
          </div>
        </div>
      </div>

      <div className="generator-actions">
        <button
          className="btn btn-primary btn-large"
          onClick={_ => handleGenerate()}
          disabled={mode == CustomText && customText->Js.String2.trim == ""}>
          {React.string("開始練習")}
        </button>
      </div>
    </div>
  </div>
}

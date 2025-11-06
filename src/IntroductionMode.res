// Introduction mode - teaches new radicals

open Types

@react.component
let make = (~lesson: lesson, ~onContinue: unit => unit) => {
  // Create a set of keys being introduced for highlighting
  let introducedKeyStrings = lesson.introducedKeys->Js.Array2.map(CangjieUtils.keyToString)

  <div className="introduction-mode">
    <div className="intro-content">
      <h2> {React.string("新字根介紹")} </h2>
      <p className="intro-description"> {React.string(lesson.description)} </p>

      // Show keyboard with new keys highlighted
      <div className="intro-keyboard-section">
        <h3> {React.string("本課學習的按鍵")} </h3>
        <div className="intro-keyboard-wrapper">
          {introducedKeyStrings->Js.Array2.map(key => {
            <div key={key} className="intro-key-highlight">
              <div className="intro-key-letter"> {React.string(key)} </div>
              <div className="intro-key-radical">
                {React.string(
                  switch CangjieUtils.stringToKey(key) {
                  | Some(k) => CangjieUtils.keyToRadicalName(k)
                  | None => ""
                  }
                )}
              </div>
            </div>
          })->React.array}
        </div>
      </div>

      <div className="radicals-grid">
        {lesson.introducedKeys
        ->Js.Array2.map(key => {
          <div key={CangjieUtils.keyToString(key)} className="radical-card">
            <div className="radical-key"> {React.string(CangjieUtils.keyToString(key))} </div>
            <div className="radical-char"> {React.string(CangjieUtils.keyToRadicalName(key))} </div>
            <div className="radical-description">
              {React.string(CangjieUtils.keyToDescription(key))}
            </div>
          </div>
        })
        ->React.array}
      </div>

      <div className="example-characters">
        <h3> {React.string("範例字符")} </h3>
        <div className="characters-list">
          {lesson.characters
          ->Js.Array2.map(charInfo => {
            <div key={charInfo.character} className="character-example">
              <div className="character-display"> {React.string(charInfo.character)} </div>
              <div className="character-code">
                {React.string(CangjieUtils.keysToCode(charInfo.cangjieCode))}
              </div>
              <div className="character-breakdown">
                {charInfo.cangjieCode
                ->Js.Array2.map(key => {
                  <span key={CangjieUtils.keyToString(key)} className="code-part">
                    {React.string(
                      `${CangjieUtils.keyToString(key)}(${CangjieUtils.keyToRadicalName(key)})`,
                    )}
                  </span>
                })
                ->React.array}
              </div>
            </div>
          })
          ->React.array}
        </div>
      </div>

      <div className="intro-actions">
        <button className="btn btn-primary btn-large" onClick={_ => onContinue()}>
          {React.string("開始練習")}
        </button>
      </div>
    </div>
  </div>
}

// Introduction mode - teaches new radicals

open Types

@react.component
let make = (~lesson: lesson, ~onContinue: unit => unit, ~onBack: unit => unit) => {
  // Create a set of keys being introduced for highlighting
  let introducedKeyStrings = lesson.introducedKeys->Js.Array2.map(CangjieUtils.keyToString)

  // Deduplicate characters - show each unique character only once
  let uniqueCharacters = {
    let seen = Js.Dict.empty()
    lesson.characters->Js.Array2.filter(charInfo => {
      let char = charInfo.character
      if Js.Dict.get(seen, char)->Belt.Option.isSome {
        false
      } else {
        Js.Dict.set(seen, char, true)
        true
      }
    })
  }

  <div className="lesson-view">
    <div className="lesson-header">
      <button className="btn btn-back" onClick={_ => onBack()}> {React.string("← 返回")} </button>
      <h1 className="lesson-title"> {React.string(lesson.title)} </h1>
    </div>

    <div className="introduction-mode">
      <div className="intro-content">
        <h2> {React.string("本課內容")} </h2>

        // Show keyboard with new keys highlighted
        <div className="intro-keyboard-section">
          <h3> {React.string("學習按鍵")} </h3>
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
                <div className="intro-key-description">
                  {React.string(
                    switch CangjieUtils.stringToKey(key) {
                    | Some(k) => CangjieUtils.keyToDescription(k)
                    | None => ""
                    }
                  )}
                </div>
              </div>
            })->React.array}
          </div>
        </div>

        <div className="example-characters">
          <h3> {React.string("練習字符")} </h3>
          <div className="characters-list">
            {uniqueCharacters
            ->Js.Array2.map(charInfo => {
              <div key={charInfo.character} className="character-example">
                <div className="character-display"> {React.string(charInfo.character)} </div>
                <div className="character-code">
                  {React.string(CangjieUtils.keysToCode(charInfo.cangjieCode))}
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
  </div>
}

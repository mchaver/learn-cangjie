// Introduction mode - teaches new radicals

open Types

@val @scope("document") external addEventListener: (string, 'a => unit) => unit = "addEventListener"
@val @scope("document") external removeEventListener: (string, 'a => unit) => unit = "removeEventListener"

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

  // Separate single-key and multi-key characters
  let (singleKeyChars, multiKeyChars) = uniqueCharacters->Js.Array2.reduce(
    ((singles, multis), charInfo) => {
      if charInfo.cangjieCode->Js.Array2.length > 1 {
        (singles, multis->Js.Array2.concat([charInfo]))
      } else {
        (singles->Js.Array2.concat([charInfo]), multis)
      }
    },
    ([], [])
  )

  // State for multi-key character practice
  let (currentMultiIndex, setCurrentMultiIndex) = React.useState(() => 0)
  let (currentAttempt, setCurrentAttempt) = React.useState(() => 0) // 0, 1, 2 for three attempts
  let (currentInput, setCurrentInput) = React.useState(() => "")
  let (wrongBoxIndex, setWrongBoxIndex) = React.useState(() => None)

  let currentMultiChar = multiKeyChars->Belt.Array.get(currentMultiIndex)
  let allMultiPracticeComplete = currentMultiIndex >= multiKeyChars->Js.Array2.length

  // Handle keyboard input for multi-char practice
  React.useEffect0(() => {
    let handleKeyDown = event => {
      let keyStr: string = (event->Obj.magic)["key"]
      let key = keyStr->Js.String2.toUpperCase

      if !allMultiPracticeComplete {
        switch currentMultiChar {
        | Some(charInfo) => {
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
            let currentLength = currentInput->Js.String2.length

            if currentLength < expectedCode->Js.String2.length {
              let expectedChar = expectedCode->Js.String2.charAt(currentLength)
              let isCorrect = key == expectedChar

              if isCorrect {
                let newInput = currentInput ++ key
                setCurrentInput(_ => newInput)

                // Check if completed this attempt
                if newInput == expectedCode {
                  // Move to next attempt or next character
                  let _ = Js.Global.setTimeout(() => {
                    if currentAttempt < 2 {
                      // Move to next attempt
                      setCurrentAttempt(prev => prev + 1)
                      setCurrentInput(_ => "")
                    } else {
                      // Move to next multi-char
                      setCurrentMultiIndex(prev => prev + 1)
                      setCurrentAttempt(_ => 0)
                      setCurrentInput(_ => "")
                    }
                  }, 400)
                  ()
                }
              } else if key->Js.String2.length == 1 && key >= "A" && key <= "Z" {
                // Wrong key pressed
                setWrongBoxIndex(_ => Some(currentLength))
                let _ = Js.Global.setTimeout(() => {
                  setWrongBoxIndex(_ => None)
                }, 300)
                ()
              }
            }
          }
        | None => ()
        }
      }
    }

    addEventListener("keydown", handleKeyDown)
    Some(() => removeEventListener("keydown", handleKeyDown))
  })

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

        // Show single-key characters if any
        {if singleKeyChars->Js.Array2.length > 0 {
          <div className="example-characters">
            <h3> {React.string("單鍵字符")} </h3>
            <div className="characters-list">
              {singleKeyChars
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
        } else {
          React.null
        }}

        // Multi-character practice section
        {if multiKeyChars->Js.Array2.length > 0 && !allMultiPracticeComplete {
          <div className="multi-char-practice">
            <h3> {React.string("組合字符練習")} </h3>
            <div className="practice-instruction">
              {React.string("請輸入正確的倉頡碼三次")}
            </div>
            {switch currentMultiChar {
            | Some(charInfo) => {
                let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
                let codeLength = expectedCode->Js.String2.length

                <div className="multi-char-practice-container">
                  <div className="practice-left">
                    <div className="practice-character"> {React.string(charInfo.character)} </div>
                    <div className="practice-code-display">
                      {React.string(expectedCode)}
                    </div>
                    <div className="practice-progress">
                      {React.string(
                        `字符 ${Belt.Int.toString(currentMultiIndex + 1)} / ${Belt.Int.toString(multiKeyChars->Js.Array2.length)}`
                      )}
                    </div>
                  </div>

                  <div className="practice-right">
                    {Belt.Array.range(0, 2)->Js.Array2.map(attemptNum => {
                      let isCurrentAttempt = attemptNum == currentAttempt
                      let isCompleted = attemptNum < currentAttempt
                      let attemptInput = if isCurrentAttempt { currentInput } else if isCompleted { expectedCode } else { "" }

                      <div key={Belt.Int.toString(attemptNum)} className={`practice-row ${isCurrentAttempt ? "current-row" : ""} ${isCompleted ? "completed-row" : ""}`}>
                        <div className="row-number"> {React.string(Belt.Int.toString(attemptNum + 1))} </div>
                        <div className="char-input-boxes">
                          {Belt.Array.range(0, codeLength - 1)
                          ->Js.Array2.map(i => {
                            let inputChar = if i < attemptInput->Js.String2.length {
                              Some(attemptInput->Js.String2.charAt(i))
                            } else {
                              None
                            }
                            let isWrongBox = isCurrentAttempt && wrongBoxIndex == Some(i)

                            <div key={Belt.Int.toString(i)} className={`input-box ${isWrongBox ? "input-box-error" : ""}`}>
                              {switch inputChar {
                              | Some(c) => {
                                  let radical = CangjieUtils.stringToKey(c)
                                    ->Belt.Option.map(CangjieUtils.keyToRadicalName)
                                    ->Belt.Option.getWithDefault(c)
                                  <span className="input-radical"> {React.string(radical)} </span>
                                }
                              | None => React.null
                              }}
                            </div>
                          })
                          ->React.array}
                        </div>
                      </div>
                    })->React.array}
                  </div>
                </div>
              }
            | None => React.null
            }}
          </div>
        } else {
          React.null
        }}

        <div className="intro-actions">
          {if allMultiPracticeComplete {
            <button className="btn btn-primary btn-large" onClick={_ => onContinue()}>
              {React.string("開始練習")}
            </button>
          } else if multiKeyChars->Js.Array2.length == 0 {
            <button className="btn btn-primary btn-large" onClick={_ => onContinue()}>
              {React.string("開始練習")}
            </button>
          } else {
            <div className="practice-hint">
              {React.string("請完成所有組合字符練習後繼續")}
            </div>
          }}
        </div>
      </div>
    </div>
  </div>
}

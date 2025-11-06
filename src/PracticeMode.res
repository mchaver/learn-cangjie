// Practice mode - typing practice with direct keyboard input

open Types

@val @scope("document") external addEventListener: (string, 'a => unit) => unit = "addEventListener"
@val @scope("document") external removeEventListener: (string, 'a => unit) => unit = "removeEventListener"

@react.component
let make = (
  ~lesson: lesson,
  ~inputState: inputState,
  ~setInputState: (inputState => inputState) => unit,
  ~onComplete: unit => unit,
) => {
  // Track last key pressed for animation (key, isCorrect)
  let (lastKeyPressed, setLastKeyPressed) = React.useState(() => None)

  // Track if showing error state
  let (showError, setShowError) = React.useState(() => false)

  let currentChar = lesson.characters->Belt.Array.get(inputState.currentIndex)

  let handleKeyDown = (event: {..}) => {
    let key = event["key"]->Js.String2.toUpperCase

    // Only handle letter keys A-Z
    if key->Js.String2.length == 1 && Js.Re.test_(%re("/^[A-Z]$/"), key) {
      event["preventDefault"]()

      switch currentChar {
      | None => ()
      | Some(charInfo) => {
          let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
          // Debug logging
          Js.Console.log(`Key pressed: ${key}, Expected: ${expectedCode}, Current char: ${charInfo.character}, Index: ${Belt.Int.toString(inputState.currentIndex)}`)

          let currentLength = inputState.currentInput->Js.String2.length

          if currentLength < expectedCode->Js.String2.length {
            let expectedChar = expectedCode->Js.String2.charAt(currentLength)
            let isCorrect = key == expectedChar

            // Trigger animation and sound
            setLastKeyPressed(_ => Some((key, isCorrect)))

            if isCorrect {
              let newInput = inputState.currentInput ++ key

              // Check if we've completed this character
              if newInput == expectedCode {
                let isLast = inputState.currentIndex == lesson.characters->Js.Array2.length - 1

                // Move to next character
                setInputState(prev => {
                  {
                    currentIndex: prev.currentIndex + 1,
                    currentInput: "",
                    stats: {
                      ...prev.stats,
                      totalCharacters: prev.stats.totalCharacters + 1,
                      correctCharacters: prev.stats.correctCharacters + 1,
                    },
                    errors: prev.errors,
                  }
                })

                if isLast {
                  onComplete()
                }
              } else {
                // Add correct key to input
                setInputState(prev => {
                  {...prev, currentInput: newInput}
                })
              }
            } else {
              // Wrong key - for single character codes, flash error
              if expectedCode->Js.String2.length == 1 {
                setShowError(_ => true)
                let _ = Js.Global.setTimeout(() => {
                  setShowError(_ => false)
                }, 300)
                ()

                setInputState(prev => {
                  {
                    ...prev,
                    stats: {
                      ...prev.stats,
                      totalCharacters: prev.stats.totalCharacters + 1,
                      incorrectCharacters: prev.stats.incorrectCharacters + 1,
                    },
                    errors: prev.errors->Js.Array2.concat([(prev.currentIndex, key)]),
                  }
                })
              }
              // For multi-character, just don't add the key (ignore wrong input)
            }
          }
        }
      }
    }
  }

  // Add keyboard event listener
  React.useEffect0(() => {
    addEventListener("keydown", handleKeyDown)
    Some(() => removeEventListener("keydown", handleKeyDown))
  })

  let progress = Belt.Float.fromInt(inputState.currentIndex) /. Belt.Float.fromInt(
    lesson.characters->Js.Array2.length,
  ) *. 100.0

  // Calculate next expected key for keyboard highlighting
  let nextExpectedKey = switch currentChar {
  | None => None
  | Some(charInfo) => {
      let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
      let currentLength = inputState.currentInput->Js.String2.length
      if currentLength < expectedCode->Js.String2.length {
        let nextChar = expectedCode->Js.String2.charAt(currentLength)
        Some(nextChar)
      } else {
        None
      }
    }
  }

  // Calculate which batch of 8 characters we're showing
  let batchIndex = inputState.currentIndex / 8
  let batchStartIndex = batchIndex * 8
  let batchEndIndex = Js.Math.min_int(batchStartIndex + 8, lesson.characters->Js.Array2.length)
  let visibleChars = lesson.characters->Js.Array2.slice(~start=batchStartIndex, ~end_=batchEndIndex)
  let relativeCurrentIndex = inputState.currentIndex - batchStartIndex

  <div className="practice-mode">
    <div className="practice-header">
      <div className="progress-bar">
        <div className="progress-fill" style={ReactDOM.Style.make(~width=`${Belt.Float.toString(progress)}%`, ())} />
      </div>
      <div className="practice-stats">
        <span className="stat">
          {React.string(
            `${Belt.Int.toString(inputState.currentIndex)} / ${Belt.Int.toString(lesson.characters->Js.Array2.length)}`,
          )}
        </span>
        <span className="stat">
          {React.string(
            `準確率: ${Js.Float.toFixedWithPrecision(
                CangjieUtils.calculateAccuracy(
                  inputState.stats.correctCharacters,
                  inputState.stats.totalCharacters,
                ) *. 100.0,
                ~digits=1,
              )}%`,
          )}
        </span>
      </div>
    </div>

    <div className="practice-area">
      {switch currentChar {
      | None => <div className="practice-complete"> {React.string("練習完成！")} </div>
      | Some(_) =>
        <div className="characters-row">
          {visibleChars
          ->Js.Array2.mapi((charInfo, idx) => {
            let isCurrentChar = idx == relativeCurrentIndex
            let isCompleted = idx < relativeCurrentIndex
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)

            <div
              key={Belt.Int.toString(batchStartIndex + idx)}
              className={`char-item ${isCurrentChar ? "current-char" : ""} ${isCompleted ? "completed-char" : ""} ${isCurrentChar && showError ? "error-char" : ""}`}
            >
              <div className="char-main"> {React.string(charInfo.character)} </div>
              {isCompleted
                ? <div className="char-checkmark"> {React.string("✓")} </div>
                : React.null}
              {isCurrentChar && expectedCode->Js.String2.length > 1
                ? <div className="char-input-boxes">
                    {Belt.Array.range(0, expectedCode->Js.String2.length - 1)
                    ->Js.Array2.map(i => {
                      let inputChar = if i < inputState.currentInput->Js.String2.length {
                        Some(inputState.currentInput->Js.String2.charAt(i))
                      } else {
                        None
                      }

                      <div key={Belt.Int.toString(i)} className="input-box">
                        {switch inputChar {
                        | Some(c) => React.string(c)
                        | None => React.null
                        }}
                      </div>
                    })
                    ->React.array}
                  </div>
                : React.null}
            </div>
          })
          ->React.array}
        </div>
      }}
    </div>

    <AnimatedKeyboard nextKey={nextExpectedKey} lastKeyPressed={lastKeyPressed} showRadicals={true} />
  </div>
}

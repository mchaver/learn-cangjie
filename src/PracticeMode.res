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

  // Track wrong input box index for multi-char error flash
  let (wrongBoxIndex, setWrongBoxIndex) = React.useState(() => None)

  // Track just completed multi-char for fade-out animation
  let (justCompleted, setJustCompleted) = React.useState(() => None)

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

                // For multi-char codes, trigger fade-out animation
                if expectedCode->Js.String2.length > 1 {
                  setJustCompleted(_ => Some(newInput))
                  let _ = Js.Global.setTimeout(() => {
                    setJustCompleted(_ => None)
                  }, 600)
                  ()
                }

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
              // Wrong key - flash error
              if expectedCode->Js.String2.length == 1 {
                // For single character, flash the whole character
                setShowError(_ => true)
                let _ = Js.Global.setTimeout(() => {
                  setShowError(_ => false)
                }, 300)
                ()
              } else {
                // For multi-character, flash the specific input box
                setWrongBoxIndex(_ => Some(currentLength))
                let _ = Js.Global.setTimeout(() => {
                  setWrongBoxIndex(_ => None)
                }, 300)
                ()
              }

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
          }
        }
      }
    }
  }

  // Add keyboard event listener - re-register when state changes to avoid stale closures
  React.useEffect2(() => {
    addEventListener("keydown", handleKeyDown)
    Some(() => removeEventListener("keydown", handleKeyDown))
  }, (inputState.currentIndex, inputState.currentInput))

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
            let isPrevCompleted = idx == relativeCurrentIndex - 1
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
            let shouldShowFadeOut = isPrevCompleted && justCompleted->Belt.Option.isSome

            <div key={Belt.Int.toString(batchStartIndex + idx)} className="char-wrapper">
              {isCompleted
                ? <div className="char-checkmark-above"> {React.string("✓")} </div>
                : React.null}
              <div
                className={`char-item ${isCurrentChar ? "current-char" : ""} ${isCompleted ? "completed-char" : ""} ${isCurrentChar && showError ? "error-char" : ""}`}
              >
                <div className="char-main"> {React.string(charInfo.character)} </div>
                {isCurrentChar && expectedCode->Js.String2.length > 1
                  ? <div className="char-input-boxes">
                      {Belt.Array.range(0, expectedCode->Js.String2.length - 1)
                      ->Js.Array2.map(i => {
                        let inputChar = if i < inputState.currentInput->Js.String2.length {
                          Some(inputState.currentInput->Js.String2.charAt(i))
                        } else {
                          None
                        }
                        let isWrongBox = switch wrongBoxIndex {
                        | Some(idx) => idx == i
                        | None => false
                        }

                        <div key={Belt.Int.toString(i)} className={`input-box ${isWrongBox ? "input-box-error" : ""}`}>
                          {switch inputChar {
                          | Some(c) => {
                              // Convert roman letter to Cangjie radical
                              let radical = CangjieUtils.stringToKey(c)
                                ->Belt.Option.map(CangjieUtils.keyToRadicalName)
                                ->Belt.Option.getWithDefault(c)
                              React.string(radical)
                            }
                          | None => React.null
                          }}
                        </div>
                      })
                      ->React.array}
                    </div>
                  : React.null}
                {shouldShowFadeOut && expectedCode->Js.String2.length > 1
                  ? <div className="char-input-boxes fade-out">
                      {Belt.Array.range(0, expectedCode->Js.String2.length - 1)
                      ->Js.Array2.map(i => {
                        let completedInput = justCompleted->Belt.Option.getWithDefault("")
                        let inputChar = if i < completedInput->Js.String2.length {
                          Some(completedInput->Js.String2.charAt(i))
                        } else {
                          None
                        }

                        <div key={Belt.Int.toString(i)} className="input-box">
                          {switch inputChar {
                          | Some(c) => {
                              // Convert roman letter to Cangjie radical
                              let radical = CangjieUtils.stringToKey(c)
                                ->Belt.Option.map(CangjieUtils.keyToRadicalName)
                                ->Belt.Option.getWithDefault(c)
                              React.string(radical)
                            }
                          | None => React.null
                          }}
                        </div>
                      })
                      ->React.array}
                    </div>
                  : React.null}
              </div>
            </div>
          })
          ->React.array}
        </div>
      }}
    </div>

    <AnimatedKeyboard nextKey={nextExpectedKey} lastKeyPressed={lastKeyPressed} showRadicals={true} />
  </div>
}

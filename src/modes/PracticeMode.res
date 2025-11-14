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

  // Track hint visibility
  let (showHint, setShowHint) = React.useState(() => false)

  // Track first-time multi-character practice
  let (firstTimeAttempt, setFirstTimeAttempt) = React.useState(() => 0) // 0, 1, 2 for three attempts

  // Track keyboard visibility
  let (keyboardVisible, setKeyboardVisible) = React.useState(() => LocalStorage.getKeyboardVisibility())

  // Toggle keyboard visibility and save preference
  let toggleKeyboard = () => {
    setKeyboardVisible(prev => {
      let newValue = !prev
      LocalStorage.setKeyboardVisibility(newValue)
      newValue
    })
  }

  let currentChar = lesson.characters->Belt.Array.get(inputState.currentIndex)

  // Determine if we're in review mode
  let isReviewMode = lesson.lessonType == Review

  // Get practice repeat mode setting
  let practiceRepeatMode = LocalStorage.getPracticeRepeatMode()

  // Get character-to-earliest-lesson map (for EarliestLesson mode)
  let earliestLessonMap = React.useMemo0(() => {
    CangjieData.getCharacterEarliestLessonMap()
  })

  // Build a map of multi-character codes to their first occurrence index in this lesson
  let firstOccurrenceMap = React.useMemo1(() => {
    let map = Belt.MutableMap.String.make()
    lesson.characters->Js.Array2.forEachi((charInfo, idx) => {
      let isMultiChar = charInfo.cangjieCode->Js.Array2.length > 1
      if isMultiChar {
        switch map->Belt.MutableMap.String.get(charInfo.character) {
        | None => map->Belt.MutableMap.String.set(charInfo.character, idx)
        | Some(_) => () // Already recorded first occurrence
        }
      }
    })
    map
  }, [lesson])

  // Check if current character should trigger "practice three times"
  // Based on user's practice repeat mode setting
  let isFirstTimeMultiChar = switch currentChar {
  | None => false
  | Some(charInfo) => {
      let isMultiChar = charInfo.cangjieCode->Js.Array2.length > 1
      if !isMultiChar {
        false
      } else {
        // Apply setting logic
        switch practiceRepeatMode {
        | Never => false // Never show practice-three-times
        | AnyLesson => {
            // Show on first occurrence within this lesson (original behavior)
            switch firstOccurrenceMap->Belt.MutableMap.String.get(charInfo.character) {
            | Some(firstIdx) => firstIdx == inputState.currentIndex
            | None => false
            }
          }
        | EarliestLesson => {
            // Only show if this is the earliest lesson where character appears
            switch earliestLessonMap->Belt.Map.String.get(charInfo.character) {
            | Some(earliestLessonId) => {
                // This is the earliest lesson AND first occurrence in this lesson
                let isEarliestLesson = earliestLessonId == lesson.id
                let isFirstInLesson = switch firstOccurrenceMap->Belt.MutableMap.String.get(charInfo.character) {
                | Some(firstIdx) => firstIdx == inputState.currentIndex
                | None => false
                }
                isEarliestLesson && isFirstInLesson
              }
            | None => false
            }
          }
        }
      }
    }
  }

  // Reset first-time attempt counter when moving to a new character
  React.useEffect1(() => {
    setFirstTimeAttempt(_ => 0)
    None
  }, [inputState.currentIndex])

  // Handle hint button click
  let handleShowHint = () => {
    setShowHint(_ => true)
    // Record hint usage
    switch currentChar {
    | Some(charInfo) => LocalStorage.recordHintUsed(charInfo.character, isReviewMode)
    | None => ()
    }
  }

  // Handle give up button click
  let handleGiveUp = () => {
    switch currentChar {
    | Some(charInfo) => {
        // Record give up
        LocalStorage.recordGiveUp(charInfo.character, isReviewMode)

        // Move to next character
        let isLast = inputState.currentIndex == lesson.characters->Js.Array2.length - 1

        setInputState(prev => {
          {
            currentIndex: prev.currentIndex + 1,
            currentInput: "",
            stats: {
              ...prev.stats,
              totalCharacters: prev.stats.totalCharacters + 1,
              incorrectCharacters: prev.stats.incorrectCharacters + 1,
            },
            errors: prev.errors->Js.Array2.concat([(prev.currentIndex, "GIVE_UP")]),
          }
        })

        // Hide hint for next character
        setShowHint(_ => false)

        if isLast {
          onComplete()
        }
      }
    | None => ()
    }
  }

  // Shared key processing logic for both keyboard and click events
  let processKeyInput = (key: string) => {
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

              // Handle first-time multi-character practice (need 3 completions)
              if isFirstTimeMultiChar && firstTimeAttempt < 2 {
                // Increment attempt counter and reset input
                setFirstTimeAttempt(prev => prev + 1)
                setInputState(prev => {...prev, currentInput: ""})
              } else {
                // Record correct attempt in character progress
                LocalStorage.recordCorrectAttempt(charInfo.character, lesson.showCode || showHint)

                // Hide hint for next character
                setShowHint(_ => false)

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
              }
            } else {
              // Add correct key to input
              setInputState(prev => {
                {...prev, currentInput: newInput}
              })
            }
          } else {
            // Wrong key - flash error
            // Record incorrect attempt in character progress
            LocalStorage.recordIncorrectAttempt(charInfo.character)

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

  // Handle physical keyboard input
  let handleKeyDown = (event: {..}) => {
    let key = event["key"]->Js.String2.toUpperCase

    // Only handle letter keys A-Z
    if key->Js.String2.length == 1 && Js.Re.test_(%re("/^[A-Z]$/"), key) {
      event["preventDefault"]()
      processKeyInput(key)
    }
  }

  // Handle virtual keyboard clicks
  let handleKeyClick = (key: string) => {
    processKeyInput(key)
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
      | Some(charInfo) => {
          // Show special layout for first-time multi-character
          if isFirstTimeMultiChar {
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
            let codeLength = expectedCode->Js.String2.length

            <div className="first-time-multi-practice">
              <div className="first-time-left">
                <div className="first-time-character"> {React.string(charInfo.character)} </div>
                <div className="first-time-code-display">
                  {React.string(
                    charInfo.cangjieCode
                    ->Js.Array2.map(CangjieUtils.keyToRadicalName)
                    ->Js.Array2.joinWith("")
                  )}
                </div>
                <div className="first-time-progress">
                  {React.string(`第 ${Belt.Int.toString(firstTimeAttempt + 1)} / 3 次練習`)}
                </div>
              </div>

              <div className="first-time-right">
                {Belt.Array.range(0, 2)->Js.Array2.map(attemptNum => {
                  let isCurrentAttempt = attemptNum == firstTimeAttempt
                  let isCompleted = attemptNum < firstTimeAttempt
                  let attemptInput = if isCurrentAttempt { inputState.currentInput } else if isCompleted { expectedCode } else { "" }

                  <div key={Belt.Int.toString(attemptNum)} className={`first-time-row ${isCurrentAttempt ? "current-row" : ""} ${isCompleted ? "completed-row" : ""}`}>
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
          } else {
            // Normal characters row view
            <div className="characters-row">
              {visibleChars
              ->Js.Array2.mapi((charInfo, idx) => {
            let isCurrentChar = idx == relativeCurrentIndex
            let isCompleted = idx < relativeCurrentIndex
            let isPrevCompleted = idx == relativeCurrentIndex - 1
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
            let shouldShowFadeOut = isPrevCompleted && justCompleted->Belt.Option.isSome

            // Check if this character had any errors
            let absoluteIndex = batchStartIndex + idx
            let hadError = inputState.errors->Js.Array2.some(((errorIdx, _)) => errorIdx == absoluteIndex)

            <div key={Belt.Int.toString(batchStartIndex + idx)} className="char-wrapper">
              {isCompleted
                ? <div className={hadError ? "char-x-above" : "char-checkmark-above"}>
                    {React.string(hadError ? "✗" : "✓")}
                  </div>
                : React.null}
              <div
                className={`char-item ${isCurrentChar ? "current-char" : ""} ${isCompleted && !hadError ? "completed-char" : ""} ${isCompleted && hadError ? "error-char" : ""} ${isCurrentChar && showError ? "error-char" : ""}`}
              >
                <div className="char-main"> {React.string(charInfo.character)} </div>
                {isCurrentChar && (lesson.showCode || showHint)
                  ? <div className="char-code-hint">
                      {React.string(expectedCode)}
                      {React.string(" → ")}
                      {React.string(
                        charInfo.cangjieCode
                        ->Js.Array2.map(CangjieUtils.keyToRadicalName)
                        ->Js.Array2.joinWith("")
                      )}
                    </div>
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
                        let isWrongBox = switch wrongBoxIndex {
                        | Some(idx) => idx == i
                        | None => false
                        }

                        <div key={`current-${Belt.Int.toString(i)}`} className={`input-box ${isWrongBox ? "input-box-error" : ""}`}>
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

                        <div key={`fadeout-${Belt.Int.toString(i)}`} className="input-box">
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
          }
        }
      }}
    </div>

    {switch currentChar {
    | None => React.null
    | Some(_) =>
      <div className="practice-controls">
        {lesson.allowHints && !showHint
          ? <button className="hint-button" onClick={_ => handleShowHint()}>
              {React.string("顯示提示")}
            </button>
          : React.null}
        {lesson.allowGiveUp
          ? <button className="give-up-button" onClick={_ => handleGiveUp()}>
              {React.string("跳過")}
            </button>
          : React.null}
        <button className="keyboard-toggle-button" onClick={_ => toggleKeyboard()}>
          {React.string(keyboardVisible ? "隱藏鍵盤" : "顯示鍵盤")}
        </button>
      </div>
    }}

    {keyboardVisible
      ? <AnimatedKeyboard nextKey={nextExpectedKey} lastKeyPressed={lastKeyPressed} showRadicals={true} onKeyClick={handleKeyClick} highlightNextKey={lesson.lessonType == Practice} />
      : React.null}
  </div>
}

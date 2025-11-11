// Timed Challenge mode - type as many characters as possible within time limit

open Types

// Proper DOM element binding for focus that works with any object
@send external focus: {..} => unit = "focus"

@react.component
let make = (
  ~lesson: lesson,
  ~inputState: inputState,
  ~setInputState: (inputState => inputState) => unit,
  ~onComplete: unit => unit,
  ~durationSeconds: int,
) => {
  let inputRef = React.useRef(Js.Nullable.null)
  let (timeRemaining, setTimeRemaining) = React.useState(() => durationSeconds)
  let (timerActive, setTimerActive) = React.useState(() => true)

  // Focus input on mount
  React.useEffect0(() => {
    inputRef.current
    ->Js.Nullable.toOption
    ->Option.forEach(elem => focus(elem->ReactDOM.domElementToObj))
    None
  })

  // Countdown timer
  React.useEffect1(() => {
    if timerActive && timeRemaining > 0 {
      let intervalId = Js.Global.setInterval(() => {
        setTimeRemaining(prev => {
          let newTime = prev - 1
          if newTime <= 0 {
            setTimerActive(_ => false)
            onComplete()
          }
          newTime
        })
      }, 1000)

      Some(() => Js.Global.clearInterval(intervalId))
    } else {
      None
    }
  }, [timerActive])

  let currentChar = lesson.characters->Belt.Array.get(inputState.currentIndex)

  let handleSubmit = () => {
    if !timerActive {
      () // Do nothing if timer is done
    } else {
      switch currentChar {
      | None => ()
      | Some(charInfo) => {
          let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
          let isCorrect = inputState.currentInput == expectedCode

          if isCorrect {
            // Correct answer - move to next character
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
          } else {
            // Incorrect answer - record error and reset input
            setInputState(prev => {
              {
                ...prev,
                currentInput: "",
                stats: {
                  ...prev.stats,
                  totalCharacters: prev.stats.totalCharacters + 1,
                  incorrectCharacters: prev.stats.incorrectCharacters + 1,
                },
                errors: prev.errors->Js.Array2.concat([(prev.currentIndex, inputState.currentInput)]),
              }
            })
          }
        }
      }
    }
  }

  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    let key = ReactEvent.Keyboard.key(event)

    // Submit on Enter key
    if key == "Enter" {
      ReactEvent.Keyboard.preventDefault(event)
      handleSubmit()
    }
  }

  let handleInputChange = (event: ReactEvent.Form.t) => {
    if timerActive {
      let value = ReactEvent.Form.target(event)["value"]
      let upperValue = value->Js.String2.toUpperCase

      setInputState(prev => {
        {...prev, currentInput: upperValue}
      })
    }
  }

  let currentCPM = CangjieUtils.calculateCPM(
    inputState.stats.correctCharacters,
    Js.Date.now() -. inputState.stats.startTime,
  )

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

  // Convert Roman letters to Cangjie radicals for display
  let displayInput = inputState.currentInput
    ->Js.String2.split("")
    ->Js.Array2.map(char => {
      switch CangjieUtils.stringToKey(char) {
      | Some(key) => CangjieUtils.keyToRadicalName(key)
      | None => char
      }
    })
    ->Js.Array2.joinWith("")

  <div className="test-mode">
    <div className="test-header">
      <div className="test-stats">
        <span className={`stat ${timeRemaining <= 10 ? "timer-warning" : ""}`}>
          {React.string(`⏱️ ${Belt.Int.toString(timeRemaining)}秒`)}
        </span>
        <span className="stat">
          {React.string(
            `已完成: ${Belt.Int.toString(inputState.stats.correctCharacters)}`,
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
        <span className="stat">
          {React.string(`速度: ${Js.Float.toFixedWithPrecision(currentCPM, ~digits=1)} 字/分`)}
        </span>
      </div>
    </div>

    <div className="test-area">
      {switch currentChar {
      | None => <div className="test-complete"> {React.string("時間到！")} </div>
      | Some(charInfo) =>
        <CharacterDisplay
          characterInfo={charInfo}
          showHint={false}
          currentInput={inputState.currentInput}
        />
      }}
    </div>

    <div className="test-input-area">
      {inputState.currentInput != ""
        ? <div className="cangjie-display">
            {displayInput->React.string}
          </div>
        : React.null}
      <div className="input-container">
        <input
          ref={ReactDOM.Ref.domRef(inputRef)}
          type_="text"
          className="cangjie-input"
          value={inputState.currentInput}
          onChange={handleInputChange}
          onKeyPress={handleKeyPress}
          autoFocus={true}
          disabled={!timerActive}
          placeholder="輸入倉頡碼..."
        />
        <button
          className="submit-button"
          onClick={_ => handleSubmit()}
          disabled={inputState.currentInput == "" || !timerActive}>
          {React.string("送出")}
        </button>
      </div>
      <div className="test-instructions">
        <p> {React.string("在時間內盡可能打出更多字！")} </p>
      </div>
    </div>

    <CangjieKeyboard nextKey={nextExpectedKey} />
  </div>
}

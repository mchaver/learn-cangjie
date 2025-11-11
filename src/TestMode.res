// Test mode - typing test without hints

open Types

// Proper DOM element binding for focus that works with any object
@send external focus: {..} => unit = "focus"

@react.component
let make = (
  ~lesson: lesson,
  ~inputState: inputState,
  ~setInputState: (inputState => inputState) => unit,
  ~onComplete: unit => unit,
) => {
  let inputRef = React.useRef(Js.Nullable.null)

  // Focus input on mount
  React.useEffect0(() => {
    inputRef.current
    ->Js.Nullable.toOption
    ->Option.forEach(elem => focus(elem->ReactDOM.domElementToObj))
    None
  })

  let currentChar = lesson.characters->Belt.Array.get(inputState.currentIndex)

  let handleSubmit = () => {
    switch currentChar {
    | None => ()
    | Some(charInfo) => {
        let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
        let isCorrect = inputState.currentInput == expectedCode
        let isLast = inputState.currentIndex == lesson.characters->Js.Array2.length - 1

        if isCorrect {
          // Correct answer
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

  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    let key = ReactEvent.Keyboard.key(event)

    // Submit on Enter key
    if key == "Enter" {
      ReactEvent.Keyboard.preventDefault(event)
      handleSubmit()
    }
  }

  let handleInputChange = (event: ReactEvent.Form.t) => {
    let value = ReactEvent.Form.target(event)["value"]
    let upperValue = value->Js.String2.toUpperCase

    setInputState(prev => {
      {...prev, currentInput: upperValue}
    })
  }

  // Handle virtual keyboard clicks
  let handleKeyClick = (key: string) => {
    setInputState(prev => {
      {...prev, currentInput: prev.currentInput ++ key}
    })
  }

  let progress = Belt.Float.fromInt(inputState.currentIndex) /. Belt.Float.fromInt(
    lesson.characters->Js.Array2.length,
  ) *. 100.0

  let elapsedTime = (Js.Date.now() -. inputState.stats.startTime) /. 1000.0
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
      <div className="progress-bar">
        <div className="progress-fill" style={ReactDOM.Style.make(~width=`${Belt.Float.toString(progress)}%`, ())} />
      </div>
      <div className="test-stats">
        <span className="stat">
          {React.string(
            `${Belt.Int.toString(inputState.currentIndex)} / ${Belt.Int.toString(lesson.characters->Js.Array2.length)}`,
          )}
        </span>
        <span className="stat">
          {React.string(`時間: ${Js.Float.toFixedWithPrecision(elapsedTime, ~digits=1)}秒`)}
        </span>
        <span className="stat">
          {React.string(`速度: ${Js.Float.toFixedWithPrecision(currentCPM, ~digits=1)} 字/分`)}
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

    <div className="test-area">
      {switch currentChar {
      | None => <div className="test-complete"> {React.string("測驗完成！")} </div>
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
          placeholder="輸入倉頡碼..."
        />
        <button
          className="submit-button"
          onClick={_ => handleSubmit()}
          disabled={inputState.currentInput == ""}
        >
          {React.string("提交")}
        </button>
      </div>
      <div className="test-instructions">
        <p> {React.string("輸入倉頡碼後按 Enter 或點擊提交按鈕")} </p>
      </div>
    </div>

    <CangjieKeyboard nextKey={nextExpectedKey} showRadicals={true} onKeyClick={handleKeyClick} />
  </div>
}

// Practice mode - typing practice with hints available

open Types

type htmlElement
@send external focus: htmlElement => unit = "focus"

@react.component
let make = (
  ~lesson: lesson,
  ~inputState: inputState,
  ~setInputState: (inputState => inputState) => unit,
  ~onComplete: unit => unit,
) => {
  let inputRef = React.useRef(Js.Nullable.null)

  // Track last key pressed for animation (key, isCorrect)
  let (lastKeyPressed, setLastKeyPressed) = React.useState(() => None)

  // Focus input on mount
  React.useEffect0(() => {
    inputRef.current
    ->Js.Nullable.toOption
    ->Belt.Option.forEach(elem => focus(elem->ReactDOM.domElementToObj->Obj.magic))
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

    // Check if a new character was added (not deleted)
    if upperValue->Js.String2.length > inputState.currentInput->Js.String2.length {
      let lastChar = upperValue->Js.String2.charAt(upperValue->Js.String2.length - 1)

      // Check if the key pressed is correct
      let isCorrect = switch currentChar {
      | None => false
      | Some(charInfo) => {
          let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
          let currentLength = inputState.currentInput->Js.String2.length
          if currentLength < expectedCode->Js.String2.length {
            let expectedChar = expectedCode->Js.String2.charAt(currentLength)
            lastChar == expectedChar
          } else {
            false
          }
        }
      }

      // Trigger animation and sound
      setLastKeyPressed(_ => Some((lastChar, isCorrect)))
    }

    setInputState(prev => {
      {...prev, currentInput: upperValue}
    })
  }

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
        // Show 8 characters at a time, with current character highlighted
        let startIndex = inputState.currentIndex
        let endIndex = Js.Math.min_int(startIndex + 8, lesson.characters->Js.Array2.length)
        let visibleChars = lesson.characters->Js.Array2.slice(~start=startIndex, ~end_=endIndex)

        <div className="characters-row">
          {visibleChars
          ->Js.Array2.mapi((charInfo, idx) => {
            let isCurrentChar = idx == 0
            let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)

            <div
              key={Belt.Int.toString(startIndex + idx)}
              className={`char-item ${isCurrentChar ? "current-char" : ""}`}
            >
              <div className="char-main"> {React.string(charInfo.character)} </div>
              {isCurrentChar && inputState.currentInput != ""
                ? <div className="char-input-display"> {React.string(inputState.currentInput)} </div>
                : React.null}
              {!isCurrentChar
                ? <div className="char-code-hint"> {React.string(expectedCode)} </div>
                : React.null}
            </div>
          })
          ->React.array}
        </div>
      }}
    </div>

    <div className="practice-input-area">
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
      <div className="practice-instructions">
        <p> {React.string("輸入倉頡碼後按 Enter 提交")} </p>
      </div>
    </div>

    <AnimatedKeyboard nextKey={nextExpectedKey} lastKeyPressed={lastKeyPressed} showRadicals={true} />
  </div>
}

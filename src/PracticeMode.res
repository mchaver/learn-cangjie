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

  // Focus input on mount
  React.useEffect0(() => {
    inputRef.current
    ->Js.Nullable.toOption
    ->Belt.Option.forEach(elem => focus(elem->ReactDOM.domElementToObj->Obj.magic))
    None
  })

  let currentChar = lesson.characters->Belt.Array.get(inputState.currentIndex)

  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    let key = ReactEvent.Keyboard.key(event)->Js.String2.toUpperCase

    switch currentChar {
    | None => ()
    | Some(charInfo) => {
        // Get expected code
        let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
        let currentInput = inputState.currentInput ++ key

        // Check if input matches so far
        let isCorrectSoFar = Js.String2.startsWith(expectedCode, currentInput)

        if isCorrectSoFar {
          // Correct input so far
          if currentInput == expectedCode {
            // Complete match - move to next character
            let isLast = inputState.currentIndex == lesson.characters->Js.Array2.length - 1

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
            // Partial match - update input
            setInputState(prev => {
              {...prev, currentInput: currentInput}
            })
          }
        } else {
          // Incorrect input - record error and reset
          setInputState(prev => {
            {
              ...prev,
              currentInput: "",
              stats: {
                ...prev.stats,
                totalCharacters: prev.stats.totalCharacters + 1,
                incorrectCharacters: prev.stats.incorrectCharacters + 1,
              },
              errors: prev.errors->Js.Array2.concat([(prev.currentIndex, currentInput)]),
            }
          })
        }
      }
    }
  }

  let handleInputChange = (event: ReactEvent.Form.t) => {
    // Prevent normal input - we handle it via keyPress
    ReactEvent.Form.preventDefault(event)
  }

  let progress = Belt.Float.fromInt(inputState.currentIndex) /. Belt.Float.fromInt(
    lesson.characters->Js.Array2.length,
  ) *. 100.0

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
      | Some(charInfo) =>
        <CharacterDisplay
          characterInfo={charInfo}
          showHint={true}
          currentInput={inputState.currentInput}
        />
      }}
    </div>

    <input
      ref={ReactDOM.Ref.domRef(inputRef)}
      type_="text"
      className="hidden-input"
      value={inputState.currentInput}
      onChange={handleInputChange}
      onKeyPress={handleKeyPress}
      autoFocus={true}
    />

    <div className="practice-instructions">
      <p> {React.string("輸入倉頡碼，或將鼠標懸停在字符上查看提示")} </p>
    </div>
  </div>
}

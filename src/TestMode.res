// Test mode - typing test without hints

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
        let expectedCode = CangjieUtils.keysToCode(charInfo.cangjieCode)
        let currentInput = inputState.currentInput ++ key

        let isCorrectSoFar = Js.String2.startsWith(expectedCode, currentInput)

        if isCorrectSoFar {
          if currentInput == expectedCode {
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
            setInputState(prev => {
              {...prev, currentInput: currentInput}
            })
          }
        } else {
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
    ReactEvent.Form.preventDefault(event)
  }

  let progress = Belt.Float.fromInt(inputState.currentIndex) /. Belt.Float.fromInt(
    lesson.characters->Js.Array2.length,
  ) *. 100.0

  let elapsedTime = (Js.Date.now() -. inputState.stats.startTime) /. 1000.0
  let currentCPM = CangjieUtils.calculateCPM(
    inputState.stats.correctCharacters,
    Js.Date.now() -. inputState.stats.startTime,
  )

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

    <input
      ref={ReactDOM.Ref.domRef(inputRef)}
      type_="text"
      className="hidden-input"
      value={inputState.currentInput}
      onChange={handleInputChange}
      onKeyPress={handleKeyPress}
      autoFocus={true}
    />

    <div className="test-instructions">
      <p> {React.string("輸入正確的倉頡碼")} </p>
    </div>
  </div>
}

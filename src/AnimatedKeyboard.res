// Animated keyboard with hand visualization and typing sounds

// Finger assignment for each key
type finger =
  | LeftPinky
  | LeftRing
  | LeftMiddle
  | LeftIndex
  | RightIndex
  | RightMiddle
  | RightRing
  | RightPinky

// Keyboard layout - 3 rows like a real keyboard
let row1Keys = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
let row2Keys = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
let row3Keys = ["Z", "X", "C", "V", "B", "N", "M"]

// Map keys to fingers (touch typing standard)
let keyToFinger = (key: string): finger => {
  switch key {
  | "Q" | "A" | "Z" => LeftPinky
  | "W" | "S" | "X" => LeftRing
  | "E" | "D" | "C" => LeftMiddle
  | "R" | "F" | "V" | "T" | "G" | "B" => LeftIndex
  | "Y" | "H" | "N" => RightIndex
  | "U" | "J" | "M" => RightIndex
  | "I" | "K" => RightMiddle
  | "O" | "L" => RightRing
  | "P" => RightPinky
  | _ => RightIndex // Default
  }
}

// Get finger name for display
let fingerToString = (finger: finger): string => {
  switch finger {
  | LeftPinky => "left-pinky"
  | LeftRing => "left-ring"
  | LeftMiddle => "left-middle"
  | LeftIndex => "left-index"
  | RightIndex => "right-index"
  | RightMiddle => "right-middle"
  | RightRing => "right-ring"
  | RightPinky => "right-pinky"
  }
}

// Get the radical for a given key
let getRadical = (key: string): option<string> => {
  switch CangjieUtils.stringToKey(key) {
  | Some(k) => Some(CangjieUtils.keyToRadicalName(k))
  | None => None
  }
}

// Placeholder audio - creates a simple beep using Web Audio API
@val @scope("window") external audioContext: Js.Nullable.t<'a> = "AudioContext"
@val @scope("window") external webkitAudioContext: Js.Nullable.t<'a> = "webkitAudioContext"

let playKeystrokeSound = (isCorrect: bool) => {
  // Try to get AudioContext (with webkit fallback for Safari)
  let ctx = switch audioContext->Js.Nullable.toOption {
  | Some(c) => Some(c)
  | None => webkitAudioContext->Js.Nullable.toOption
  }

  // If we have an audio context, play a simple tone
  switch ctx {
  | Some(context) => {
      try {
        // Create oscillator for beep sound
        let oscillator = context["createOscillator"]()
        let gainNode = context["createGain"]()

        // Connect nodes
        let _ = oscillator["connect"](gainNode)
        let _ = gainNode["connect"](context["destination"])

        // Set frequency based on correct/incorrect
        oscillator["frequency"]["value"] = if isCorrect { 800.0 } else { 400.0 }
        oscillator["type"] = "sine"

        // Set volume
        gainNode["gain"]["value"] = 0.1

        // Play short beep
        let _ = oscillator["start"](0.0)
        let _ = oscillator["stop"](context["currentTime"] +. 0.05)
        ()
      } catch {
      | _ => () // Silently fail if audio doesn't work
      }
    }
  | None => () // No audio context available
  }
}

@react.component
let make = (~nextKey: option<string>, ~lastKeyPressed: option<(string, bool)>, ~showRadicals: bool=true, ~onKeyClick: option<string => unit>=?) => {
  // Track animation state
  let (animatingKey, setAnimatingKey) = React.useState(() => None)

  // Play sound and animate when lastKeyPressed changes
  React.useEffect1(() => {
    switch lastKeyPressed {
    | Some((key, isCorrect)) => {
        playKeystrokeSound(isCorrect)
        setAnimatingKey(_ => Some(key))

        // Clear animation after short delay
        let timeoutId = Js.Global.setTimeout(() => {
          setAnimatingKey(_ => None)
        }, 150)

        Some(() => Js.Global.clearTimeout(timeoutId))
      }
    | None => None
    }
  }, [lastKeyPressed])

  let renderKey = (key: string) => {
    let isHighlighted = switch nextKey {
    | Some(next) => next->Js.String2.toUpperCase == key
    | None => false
    }

    let isAnimating = switch animatingKey {
    | Some(aKey) => aKey->Js.String2.toUpperCase == key
    | None => false
    }

    let finger = keyToFinger(key)
    let fingerClass = fingerToString(finger)
    let radical = getRadical(key)

    let handleClick = (_event) => {
      switch onKeyClick {
      | Some(callback) => callback(key)
      | None => ()
      }
    }

    <div
      key={key}
      className={`animated-key ${isHighlighted ? "key-next" : ""} ${isAnimating ? "key-pressed" : ""} finger-${fingerClass} ${onKeyClick->Belt.Option.isSome ? "clickable" : ""}`}
      onClick={handleClick}
    >
      <div className="key-letter"> {React.string(key)} </div>
      {showRadicals && radical->Belt.Option.isSome
        ? <div className="key-radical">
            {React.string(radical->Belt.Option.getWithDefault(""))}
          </div>
        : React.null}
    </div>
  }

  <div className="animated-keyboard">
    <div className="keyboard-visual">
      <div className="keyboard-row keyboard-row-1">
        {row1Keys->Js.Array2.map(renderKey)->React.array}
      </div>
      <div className="keyboard-row keyboard-row-2">
        {row2Keys->Js.Array2.map(renderKey)->React.array}
      </div>
      <div className="keyboard-row keyboard-row-3">
        {row3Keys->Js.Array2.map(renderKey)->React.array}
      </div>
    </div>
  </div>
}

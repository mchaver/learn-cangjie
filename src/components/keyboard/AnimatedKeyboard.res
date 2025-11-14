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
type audioContext
type oscillatorNode
type gainNode
type audioParam
type audioDestinationNode

@new @scope("window") external makeAudioContext: unit => audioContext = "AudioContext"
@new @scope("window") external makeWebkitAudioContext: unit => audioContext = "webkitAudioContext"
@send external createOscillator: audioContext => oscillatorNode = "createOscillator"
@send external createGain: audioContext => gainNode = "createGain"
@send external connectOscillator: (oscillatorNode, gainNode) => unit = "connect"
@send external connectGain: (gainNode, audioDestinationNode) => unit = "connect"
@get external getFrequency: oscillatorNode => audioParam = "frequency"
@get external getGain: gainNode => audioParam = "gain"
@set external setValue: (audioParam, float) => unit = "value"
@set external setType: (oscillatorNode, string) => unit = "type"
@send external start: (oscillatorNode, float) => unit = "start"
@send external stop: (oscillatorNode, float) => unit = "stop"
@get external destination: audioContext => audioDestinationNode = "destination"
@get external currentTime: audioContext => float = "currentTime"
@get external state: audioContext => string = "state"
@send external resume: audioContext => Js.Promise.t<unit> = "resume"

// Shared AudioContext - created once and reused
// This prevents the "too many AudioContext" error
let sharedAudioContext: ref<option<audioContext>> = ref(None)

let getOrCreateAudioContext = (): option<audioContext> => {
  switch sharedAudioContext.contents {
  | Some(ctx) => Some(ctx)
  | None => {
      // Try to create AudioContext (with webkit fallback for Safari)
      let ctx = try {
        Some(makeAudioContext())
      } catch {
      | _ =>
        try {
          Some(makeWebkitAudioContext())
        } catch {
        | _ => None
        }
      }

      // Store the context for reuse
      sharedAudioContext := ctx
      ctx
    }
  }
}

let playKeystrokeSound = (isCorrect: bool) => {
  // Get or create the shared audio context
  let ctx = getOrCreateAudioContext()

  // If we have an audio context, play a simple tone
  switch ctx {
  | Some(context) => {
      try {
        // Resume context if it was suspended (browsers auto-suspend to save resources)
        if context->state == "suspended" {
          context->resume->ignore
        }

        // Create oscillator for beep sound
        let oscillator = context->createOscillator
        let gainNode = context->createGain

        // Connect nodes
        oscillator->connectOscillator(gainNode)
        gainNode->connectGain(context->destination)

        // Set frequency based on correct/incorrect
        oscillator->getFrequency->setValue(if isCorrect { 800.0 } else { 400.0 })
        oscillator->setType("sine")

        // Set volume
        gainNode->getGain->setValue(0.1)

        // Play short beep
        oscillator->start(0.0)
        oscillator->stop(context->currentTime +. 0.05)
      } catch {
      | _ => () // Silently fail if audio doesn't work
      }
    }
  | None => () // No audio context available
  }
}

@react.component
let make = (~nextKey: option<string>, ~lastKeyPressed: option<(string, bool)>, ~showRadicals: bool=true, ~onKeyClick: option<string => unit>=?, ~highlightNextKey: bool=true, ~onSpaceClick: option<unit => unit>=?, ~onBackspaceClick: option<unit => unit>=?) => {
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
    let isHighlighted = highlightNextKey && switch nextKey {
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
        {switch onBackspaceClick {
        | Some(callback) =>
          <div
            className="animated-key key-special key-backspace"
            onClick={_ => callback()}
          >
            <div className="key-letter"> {React.string("×")} </div>
          </div>
        | None => React.null
        }}
      </div>
      <div className="keyboard-row keyboard-row-4">
        {switch onSpaceClick {
        | Some(callback) =>
          <div
            className="animated-key key-special key-space"
            onClick={_ => callback()}
          >
            <div className="key-radical"> {React.string("空格")} </div>
          </div>
        | None => React.null
        }}
      </div>
    </div>
  </div>
}

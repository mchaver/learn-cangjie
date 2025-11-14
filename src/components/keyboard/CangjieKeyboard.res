// Visual Cangjie keyboard overlay component

// Keyboard layout - 3 rows like a real keyboard
let row1Keys = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
let row2Keys = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
let row3Keys = ["Z", "X", "C", "V", "B", "N", "M"]

// Get the radical for a given key
let getRadical = (key: string): option<string> => {
  switch CangjieUtils.stringToKey(key) {
  | Some(k) => Some(CangjieUtils.keyToRadicalName(k))
  | None => None
  }
}

@react.component
let make = (~nextKey: option<string>, ~showRadicals: bool=true, ~onKeyClick: option<string => unit>=?, ~highlightNextKey: bool=false) => {
  let renderKey = (key: string) => {
    let isHighlighted = highlightNextKey && switch nextKey {
    | Some(next) => next->Js.String2.toUpperCase == key
    | None => false
    }

    let radical = getRadical(key)

    let handleClick = (_event) => {
      switch onKeyClick {
      | Some(callback) => callback(key)
      | None => ()
      }
    }

    <div
      key={key}
      className={`keyboard-key ${isHighlighted ? "keyboard-key-highlight" : ""} ${onKeyClick->Belt.Option.isSome ? "clickable" : ""}`}
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

  <div className="cangjie-keyboard">
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
}

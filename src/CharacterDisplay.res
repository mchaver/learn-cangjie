// Character display with optional hover hint

open Types

@react.component
let make = (~characterInfo: characterInfo, ~showHint: bool, ~currentInput as _: string) => {
  let (showDecomposition, setShowDecomposition) = React.useState(() => false)

  <div
    className="character-display-container"
    onMouseEnter={_ => setShowDecomposition(_ => true)}
    onMouseLeave={_ => setShowDecomposition(_ => false)}>
    <div className="character-main">
      <div className="character-char"> {React.string(characterInfo.character)} </div>
    </div>

    {showHint && showDecomposition
      ? <div className="character-hint">
          <div className="hint-title"> {React.string("倉頡碼")} </div>
          <div className="hint-code">
            {characterInfo.cangjieCode
            ->Js.Array2.mapi((key, i) => {
              <div key={Belt.Int.toString(i)} className="hint-code-part">
                <span className="hint-key"> {React.string(CangjieUtils.keyToString(key))} </span>
                <span className="hint-radical">
                  {React.string(CangjieUtils.keyToRadicalName(key))}
                </span>
              </div>
            })
            ->React.array}
          </div>
          <div className="hint-full-code">
            {React.string(`完整代碼: ${CangjieUtils.keysToCode(characterInfo.cangjieCode)}`)}
          </div>
          {switch characterInfo.radicals {
          | Some(radicals) =>
            <div className="hint-radicals">
              <div className="hint-radicals-title"> {React.string("部件：")} </div>
              <div className="hint-radicals-list">
                {radicals
                ->Js.Array2.mapi((radical, i) => {
                  <span key={Belt.Int.toString(i)} className="hint-radical-item">
                    {React.string(radical)}
                  </span>
                })
                ->React.array}
              </div>
            </div>
          | None => React.null
          }}
        </div>
      : React.null}
  </div>
}

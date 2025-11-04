// Dictionary/Search view component

type searchMode =
  | ByCharacter
  | ByCode

type searchState =
  | Idle
  | Searching
  | Results(array<DatabaseLoader.dbEntry>)
  | NoResults
  | Error(string)

@react.component
let make = (~onBack: unit => unit, ~database: array<DatabaseLoader.dbEntry>) => {
  let (searchMode, setSearchMode) = React.useState(() => ByCharacter)
  let (searchQuery, setSearchQuery) = React.useState(() => "")
  let (searchState, setSearchState) = React.useState(() => Idle)

  let handleSearch = () => {
    if searchQuery->Js.String2.trim == "" {
      setSearchState(_ => Idle)
    } else {
      setSearchState(_ => Searching)

      let results = switch searchMode {
      | ByCharacter => DatabaseLoader.searchByCharacter(database, searchQuery->Js.String2.trim)
      | ByCode => {
          let exact = DatabaseLoader.searchByCode(database, searchQuery->Js.String2.trim)
          if exact->Js.Array2.length > 0 {
            exact
          } else {
            // Try prefix search if exact match fails
            DatabaseLoader.searchByCodePrefix(database, searchQuery->Js.String2.trim)
              ->Js.Array2.slice(~start=0, ~end_=50) // Limit results
          }
        }
      }

      if results->Js.Array2.length > 0 {
        setSearchState(_ => Results(results))
      } else {
        setSearchState(_ => NoResults)
      }
    }
  }

  // Search on Enter key
  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    if ReactEvent.Keyboard.key(event) == "Enter" {
      handleSearch()
    }
  }

  <div className="dictionary-view">
    <div className="dictionary-header">
      <button className="btn btn-back" onClick={_ => onBack()}>
        {React.string("← 返回")}
      </button>
      <h1> {React.string("倉頡字典")} </h1>
    </div>

    <div className="dictionary-content">
      <div className="search-controls">
        <div className="search-mode-selector">
          <button
            className={`btn ${searchMode == ByCharacter ? "btn-primary" : "btn-secondary"}`}
            onClick={_ => {
              setSearchMode(_ => ByCharacter)
              setSearchState(_ => Idle)
              setSearchQuery(_ => "")
            }}>
            {React.string("查字")}
          </button>
          <button
            className={`btn ${searchMode == ByCode ? "btn-primary" : "btn-secondary"}`}
            onClick={_ => {
              setSearchMode(_ => ByCode)
              setSearchState(_ => Idle)
              setSearchQuery(_ => "")
            }}>
            {React.string("查碼")}
          </button>
        </div>

        <div className="search-input-group">
          <input
            type_="text"
            className="search-input"
            placeholder={switch searchMode {
            | ByCharacter => "輸入漢字，例如：中"
            | ByCode => "輸入倉頡碼，例如：L 或 WLMC"
            }}
            value={searchQuery}
            onChange={e => {
              let value = ReactEvent.Form.target(e)["value"]
              setSearchQuery(_ => value)
            }}
            onKeyPress={handleKeyPress}
          />
          <button className="btn btn-primary" onClick={_ => handleSearch()}>
            {React.string("搜尋")}
          </button>
        </div>

        <div className="search-hint">
          {switch searchMode {
          | ByCharacter => React.string("輸入一個漢字來查詢其倉頡碼")
          | ByCode =>
            React.string(
              "輸入倉頡碼（A-Z）來查詢對應的漢字。支援完整碼和前綴搜尋。",
            )
          }}
        </div>
      </div>

      <div className="search-results">
        {switch searchState {
        | Idle =>
          <div className="search-idle">
            <h3> {React.string("開始搜尋")} </h3>
            <p> {React.string("使用上方搜尋框來查詢漢字或倉頡碼")} </p>
            <div className="quick-examples">
              <h4> {React.string("常用字根對照：")} </h4>
              <div className="radicals-reference">
                {[
                  ("A", "日"),
                  ("B", "月"),
                  ("C", "金"),
                  ("D", "木"),
                  ("E", "水"),
                  ("F", "火"),
                  ("G", "土"),
                  ("H", "竹"),
                  ("I", "戈"),
                  ("J", "十"),
                  ("K", "大"),
                  ("L", "中"),
                ]
                ->Js.Array2.map(((code, radical)) => {
                  <span key={code} className="radical-ref">
                    {React.string(`${code} = ${radical}`)}
                  </span>
                })
                ->React.array}
              </div>
            </div>
          </div>

        | Searching => <div className="search-loading"> {React.string("搜尋中...")} </div>

        | NoResults =>
          <div className="search-no-results">
            <h3> {React.string("找不到結果")} </h3>
            <p>
              {React.string(switch searchMode {
              | ByCharacter => `找不到「${searchQuery}」的倉頡碼`
              | ByCode => `找不到倉頡碼「${searchQuery}」對應的漢字`
              })}
            </p>
          </div>

        | Error(message) =>
          <div className="search-error">
            <h3> {React.string("錯誤")} </h3>
            <p> {React.string(message)} </p>
          </div>

        | Results(results) =>
          <div className="search-results-list">
            <div className="results-header">
              {React.string(
                `找到 ${Belt.Int.toString(results->Js.Array2.length)} 個結果`,
              )}
            </div>
            <div className="results-grid">
              {results
              ->Js.Array2.slice(~start=0, ~end_=100)
              ->Js.Array2.map(entry => {
                <div key={`${entry.character}-${entry.code}`} className="result-item">
                  <div className="result-character"> {React.string(entry.character)} </div>
                  <div className="result-code">
                    <span className="code-label"> {React.string("倉頡碼：")} </span>
                    <span className="code-value"> {React.string(entry.code->Js.String2.toUpperCase)} </span>
                  </div>
                  <div className="result-breakdown">
                    {entry.code
                    ->Js.String2.toUpperCase
                    ->Js.String2.split("")
                    ->Js.Array2.map(key => {
                      switch CangjieUtils.stringToKey(key) {
                      | Some(k) =>
                        <span key={key} className="code-part">
                          {React.string(`${key}(${CangjieUtils.keyToRadicalName(k)})`)}
                        </span>
                      | None => React.null
                      }
                    })
                    ->React.array}
                  </div>
                </div>
              })
              ->React.array}
            </div>
            {results->Js.Array2.length > 100
              ? <div className="results-truncated">
                  {React.string("僅顯示前 100 個結果")}
                </div>
              : React.null}
          </div>
        }}
      </div>
    </div>
  </div>
}

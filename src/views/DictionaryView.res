// Dictionary/Search view component

type searchMode =
  | BySentence // Lookup multiple characters
  | ByCode

type charResult = {
  character: string,
  code: option<string>,
}

type searchState =
  | Idle
  | Results(array<charResult>) // For sentence mode
  | CodeResults(array<DatabaseLoader.dbEntry>) // For code search mode
  | NoResults
  | Error(string)

// Check if a character is Chinese (CJK Unified Ideographs)
let isChineseChar = (char: string): bool => {
  if Js.String2.length(char) != 1 {
    false
  } else {
    let code = Js.String2.charCodeAt(char, 0)->Belt.Int.fromFloat
    // CJK Unified Ideographs: U+4E00–U+9FFF
    // CJK Extension A: U+3400–U+4DBF
    // CJK Extension B-F: U+20000–U+2EBEF
    (code >= 0x4E00 && code <= 0x9FFF) ||
    (code >= 0x3400 && code <= 0x4DBF) ||
    (code >= 0xF900 && code <= 0xFAFF) // CJK Compatibility Ideographs
  }
}

// Lookup a single character in the database
let lookupCharacter = (database: array<DatabaseLoader.dbEntry>, char: string): option<string> => {
  let results = DatabaseLoader.searchByCharacter(database, char)
  switch results->Belt.Array.get(0) {
  | Some(entry) => Some(entry.code)
  | None => None
  }
}

// Process sentence into character results
let processSentence = (database: array<DatabaseLoader.dbEntry>, text: string): array<charResult> => {
  text
  ->Js.String2.split("")
  ->Js.Array2.filter(isChineseChar)
  ->Js.Array2.map(char => {
    {
      character: char,
      code: lookupCharacter(database, char),
    }
  })
}

@react.component
let make = (~onBack: unit => unit, ~database: array<DatabaseLoader.dbEntry>) => {
  let (searchMode, setSearchMode) = React.useState(() => BySentence)
  let (searchQuery, setSearchQuery) = React.useState(() => "")
  let (searchState, setSearchState) = React.useState(() => Idle)

  // Real-time lookup for sentence mode
  let handleInputChange = (value: string) => {
    setSearchQuery(_ => value)

    if value->Js.String2.trim == "" {
      setSearchState(_ => Idle)
    } else {
      switch searchMode {
      | BySentence => {
          let results = processSentence(database, value)
          if results->Js.Array2.length > 0 {
            setSearchState(_ => Results(results))
          } else {
            setSearchState(_ => Idle)
          }
        }
      | ByCode => () // Don't auto-search for code mode
      }
    }
  }

  let handleCodeSearch = () => {
    if searchQuery->Js.String2.trim == "" {
      setSearchState(_ => Idle)
    } else {
      let exact = DatabaseLoader.searchByCode(database, searchQuery->Js.String2.trim)
      let results = if exact->Js.Array2.length > 0 {
        exact
      } else {
        // Try prefix search if exact match fails
        DatabaseLoader.searchByCodePrefix(database, searchQuery->Js.String2.trim)
          ->Js.Array2.slice(~start=0, ~end_=50) // Limit results
      }

      if results->Js.Array2.length > 0 {
        setSearchState(_ => CodeResults(results))
      } else {
        setSearchState(_ => NoResults)
      }
    }
  }

  // Search on Enter key (for code search)
  let handleKeyPress = (event: ReactEvent.Keyboard.t) => {
    if ReactEvent.Keyboard.key(event) == "Enter" && searchMode == ByCode {
      handleCodeSearch()
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
            className={`btn ${searchMode == BySentence ? "btn-primary" : "btn-secondary"}`}
            onClick={_ => {
              setSearchMode(_ => BySentence)
              setSearchState(_ => Idle)
              setSearchQuery(_ => "")
            }}>
            {React.string("查句")}
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
            | BySentence => "輸入句子或多個漢字，例如：學習倉頡輸入法"
            | ByCode => "輸入倉頡碼，例如：L 或 WLMC"
            }}
            value={searchQuery}
            onChange={e => {
              let value = ReactEvent.Form.target(e)["value"]
              handleInputChange(value)
            }}
            onKeyPress={handleKeyPress}
          />
          {searchMode == ByCode
            ? <button className="btn btn-primary" onClick={_ => handleCodeSearch()}>
                {React.string("搜尋")}
              </button>
            : React.null}
        </div>

        <div className="search-hint">
          {switch searchMode {
          | BySentence => React.string("輸入句子或多個漢字，即時顯示每個字的倉頡碼（自動忽略非中文字符）")
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
            <p> {React.string("使用上方搜尋框來查詢句子、漢字或倉頡碼")} </p>
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

        | NoResults =>
          <div className="search-no-results">
            <h3> {React.string("找不到結果")} </h3>
            <p> {React.string(`找不到倉頡碼「${searchQuery}」對應的漢字`)} </p>
          </div>

        | Error(message) =>
          <div className="search-error">
            <h3> {React.string("錯誤")} </h3>
            <p> {React.string(message)} </p>
          </div>

        | Results(charResults) =>
          <div className="sentence-results">
            <div className="results-header">
              {React.string(`共 ${Belt.Int.toString(charResults->Js.Array2.length)} 個漢字`)}
            </div>
            <div className="sentence-grid">
              {charResults
              ->Js.Array2.mapi((result, idx) => {
                <div key={`${result.character}-${Belt.Int.toString(idx)}`} className="sentence-char-item">
                  <div className="char-display"> {React.string(result.character)} </div>
                  <div className="char-code">
                    {switch result.code {
                    | Some(code) =>
                      <>
                        <span className="code-value"> {React.string(code->Js.String2.toUpperCase)} </span>
                        <div className="code-breakdown">
                          {code
                          ->Js.String2.toUpperCase
                          ->Js.String2.split("")
                          ->Js.Array2.map(key => {
                            switch CangjieUtils.stringToKey(key) {
                            | Some(k) =>
                              <span key={key} className="code-part-small">
                                {React.string(`${key}(${CangjieUtils.keyToRadicalName(k)})`)}
                              </span>
                            | None => React.null
                            }
                          })
                          ->React.array}
                        </div>
                      </>
                    | None =>
                      <span className="code-not-found"> {React.string("未找到")} </span>
                    }}
                  </div>
                </div>
              })
              ->React.array}
            </div>
          </div>

        | CodeResults(results) =>
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

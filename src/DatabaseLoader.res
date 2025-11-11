// Database loader - loads and parses cangjie5.txt at runtime

open Types

// External bindings for Fetch API
@val external fetch: string => Js.Promise.t<'response> = "fetch"

type response
@send external text: response => Js.Promise.t<string> = "text"
@get external ok: response => bool = "ok"

// Database entry
type dbEntry = {
  code: string,
  character: string,
  frequency: int,
}

// Database state
type dbState =
  | NotLoaded
  | Loading
  | Loaded(array<dbEntry>)
  | Error(string)

// Parse a single line from the database
let parseDbLine = (line: string): option<dbEntry> => {
  let parts = line->Js.String2.split("\t")
  if parts->Js.Array2.length >= 3 {
    Some({
      code: parts->Belt.Array.get(0)->Belt.Option.getWithDefault(""),
      character: parts->Belt.Array.get(1)->Belt.Option.getWithDefault(""),
      frequency: parts->Belt.Array.get(2)
        ->Belt.Option.flatMap(s => Belt.Int.fromString(s))
        ->Belt.Option.getWithDefault(1000),
    })
  } else {
    None
  }
}

// Parse the entire database file
let parseDatabase = (text: string): array<dbEntry> => {
  text
  ->Js.String2.split("\n")
  ->Js.Array2.map(Js.String2.trim)
  ->Js.Array2.filter(line => line != "")
  ->Js.Array2.map(parseDbLine)
  ->Js.Array2.filter(Belt.Option.isSome)
  ->Js.Array2.map(Belt.Option.getExn)
}

// Fetch and load the database
let loadDatabase = (onLoad: array<dbEntry> => unit, onError: string => unit): unit => {
  fetch("/assets/cangjie5.txt")
  ->Js.Promise.then_(response => {
    if ok(response) {
      text(response)
    } else {
      Js.Promise.reject(Js.Exn.raiseError("Failed to load database"))
    }
  }, _)
  ->Js.Promise.then_(textContent => {
    let db = parseDatabase(textContent)
    onLoad(db)
    Js.Promise.resolve()
  }, _)
  ->Js.Promise.catch(_error => {
    onError("Failed to load database")
    Js.Promise.resolve()
  }, _)
  ->ignore
}

// Convert database entry to characterInfo
let dbEntryToCharacterInfo = (entry: dbEntry): characterInfo => {
  {
    character: entry.character,
    cangjieCode: CangjieUtils.codeToKeys(entry.code->Js.String2.toUpperCase),
    radicals: None,
    hskLevel: None,
    frequencyRank: None,
  }
}

// Search database by character
let searchByCharacter = (db: array<dbEntry>, char: string): array<dbEntry> => {
  db->Js.Array2.filter(entry => entry.character == char)
}

// Search database by code
let searchByCode = (db: array<dbEntry>, code: string): array<dbEntry> => {
  let upperCode = code->Js.String2.toUpperCase
  db->Js.Array2.filter(entry => entry.code->Js.String2.toUpperCase == upperCode)
}

// Search database by partial code (prefix match)
let searchByCodePrefix = (db: array<dbEntry>, prefix: string): array<dbEntry> => {
  let upperPrefix = prefix->Js.String2.toUpperCase
  db->Js.Array2.filter(entry =>
    entry.code->Js.String2.toUpperCase->Js.String2.startsWith(upperPrefix)
  )
}

// Get characters by code length (difficulty)
let getCharactersByCodeLength = (db: array<dbEntry>, length: int, count: int): array<dbEntry> => {
  db
  ->Js.Array2.filter(entry => entry.code->Js.String2.length == length)
  ->Js.Array2.slice(~start=0, ~end_=Js.Math.min_int(count, 1000))
}

// Get random characters by code length
let getRandomCharactersByCodeLength = (db: array<dbEntry>, length: int, count: int): array<dbEntry> => {
  let filtered = db->Js.Array2.filter(entry => entry.code->Js.String2.length == length)
  let shuffled = filtered->Js.Array2.copy

  // Fisher-Yates shuffle
  for i in 0 to shuffled->Js.Array2.length - 1 {
    let j = Js.Math.random_int(0, shuffled->Js.Array2.length)
    let temp = shuffled->Array.getUnsafe(i)
    shuffled->Array.setUnsafe(i, shuffled->Array.getUnsafe(j))
    shuffled->Array.setUnsafe(j, temp)
  }

  shuffled->Js.Array2.slice(~start=0, ~end_=Js.Math.min_int(count, shuffled->Js.Array2.length))
}

// Look up text and return character info array
let lookupText = (db: array<dbEntry>, text: string): array<characterInfo> => {
  let chars = text->Js.String2.split("")->Js.Array2.filter(c => c->Js.String2.trim != "")

  chars
  ->Js.Array2.map(char => {
    let results = searchByCharacter(db, char)
    results->Belt.Array.get(0)
  })
  ->Js.Array2.filter(Belt.Option.isSome)
  ->Js.Array2.map(Belt.Option.getExn)
  ->Js.Array2.map(dbEntryToCharacterInfo)
}

// Generate lesson from custom text
let generateLessonFromText = (
  db: array<dbEntry>,
  text: string,
  title: string,
  description: string,
  lessonType: lessonType,
): option<lesson> => {
  let characters = lookupText(db, text)

  if characters->Js.Array2.length > 0 {
    Some({
      id: -1, // Dynamic lessons get negative IDs
      title: title,
      description: description,
      section: Advanced,
      category: Custom,
      lessonType: lessonType,
      introducedKeys: [],
      characters: characters,
      targetAccuracy: 0.85,
      targetSpeed: Some(20.0),
      showCode: false,
      allowHints: true,
      allowGiveUp: true,
      reviewsLessons: [],
    })
  } else {
    None
  }
}

// Generate lesson by difficulty
let generateLessonByDifficulty = (
  db: array<dbEntry>,
  difficulty: string,
  count: int,
  lessonType: lessonType,
): option<lesson> => {
  let (codeLength, title, description) = switch difficulty {
  | "easy" => (1, "簡單練習（單字根）", "練習單一字根的字符")
  | "medium" => (3, "中等練習（三字根）", "練習三個字根的字符")
  | "hard" => (4, "困難練習（四字根）", "練習四個字根的字符")
  | "veryhard" => (5, "高難度練習（五字根）", "練習五個字根的字符")
  | _ => (2, "基礎練習（雙字根）", "練習兩個字根的字符")
  }

  let characters = getRandomCharactersByCodeLength(db, codeLength, count)
    ->Js.Array2.map(dbEntryToCharacterInfo)

  if characters->Js.Array2.length > 0 {
    Some({
      id: -2, // Dynamic lessons get negative IDs
      title: title,
      description: description,
      section: Advanced,
      category: Custom,
      lessonType: lessonType,
      introducedKeys: [],
      characters: characters,
      targetAccuracy: 0.85,
      targetSpeed: Some(25.0),
      showCode: false,
      allowHints: true,
      allowGiveUp: true,
      reviewsLessons: [],
    })
  } else {
    None
  }
}

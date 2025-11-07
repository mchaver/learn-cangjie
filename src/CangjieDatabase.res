// Cangjie 5 Database Module
// Parses and provides access to the comprehensive Cangjie character database

open Types

// Database entry from cangjie5.txt
type dbEntry = {
  code: string,
  character: string,
  frequency: int,
}

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

// Convert lowercase code to cangjie keys
let codeStringToKeys = (code: string): array<cangjieKey> => {
  code
  ->Js.String2.toUpperCase
  ->Js.String2.split("")
  ->Js.Array2.map(CangjieUtils.stringToKey)
  ->Js.Array2.filter(opt => opt->Belt.Option.isSome)
  ->Js.Array2.map(opt => opt->Belt.Option.getExn)
}

// Convert database entry to characterInfo
let dbEntryToCharacterInfo = (entry: dbEntry): characterInfo => {
  {
    character: entry.character,
    cangjieCode: codeStringToKeys(entry.code),
    radicals: None, // We don't have radical decomposition from this database
    hskLevel: None,
    frequencyRank: None,
  }
}

// Common single characters for basic practice (high frequency, simple codes)
let basicCharacters = [
  "人", "日", "月", "木", "水", "火", "土", "金", "山", "田",
  "中", "大", "小", "一", "二", "三", "十", "口", "手", "心",
]

// Common two-character words (Traditional Chinese)
let commonWords = [
  "中國", "人民", "時間", "地方", "工作", "生活", "社會", "經濟",
  "文化", "教育", "政府", "世界", "歷史", "問題", "發展", "國家",
  "企業", "市場", "公司", "產品", "服務", "管理", "技術", "系統",
  "資訊", "網路", "電腦", "手機", "學校", "學生", "老師", "朋友",
]

// Common three-character words
let commonThreeCharWords = [
  "可以說", "不能說", "沒有人", "這個人", "那個人", "什麼人",
  "這麼說", "那麼說", "不知道", "我知道", "你知道", "他知道",
]

// Common Chengyu (成語 - 4-character idioms)
let commonChengyu = [
  "一心一意", "三心二意", "四面八方", "五花八門", "七上八下",
  "十全十美", "百發百中", "千變萬化", "萬眾一心", "半途而廢",
  "事半功倍", "人山人海", "天長地久", "日新月異", "月明星稀",
  "水到渠成", "火燒眉毛", "金玉良言", "木已成舟", "井井有條",
]

// Simple sentences for practice
let simpleSentences = [
  "你好嗎？", "我很好。", "謝謝你。", "不客氣。",
  "今天天氣很好。", "我喜歡學習中文。", "你在做什麼？",
  "我在工作。", "這是什麼？", "那是一本書。",
]

// Medium sentences
let mediumSentences = [
  "學習倉頡輸入法可以提高打字速度。",
  "中文是世界上使用人數最多的語言。",
  "電腦科技改變了我們的生活方式。",
  "教育是國家發展的重要基礎。",
  "我們應該保護環境，愛護地球。",
]

// Get characters by code length (for progressive difficulty)
let getCharactersByCodeLength = (chars: array<string>, length: int, db: array<dbEntry>): array<characterInfo> => {
  chars
  ->Js.Array2.map(char => {
    db->Js.Array2.find(entry => entry.character == char && entry.code->Js.String2.length == length)
  })
  ->Js.Array2.filter(Belt.Option.isSome)
  ->Js.Array2.map(Belt.Option.getExn)
  ->Js.Array2.map(dbEntryToCharacterInfo)
}

// Split text into individual characters
let splitIntoCharacters = (text: string): array<string> => {
  // Handle both single and multi-byte characters
  text->Js.String2.split("")->Js.Array2.filter(c => c->Js.String2.trim != "")
}

// Look up characters in database and return characterInfo array
let lookupText = (text: string, db: array<dbEntry>): array<characterInfo> => {
  let chars = splitIntoCharacters(text)
  chars
  ->Js.Array2.map(char => {
    db->Js.Array2.find(entry => entry.character == char)
  })
  ->Js.Array2.filter(Belt.Option.isSome)
  ->Js.Array2.map(Belt.Option.getExn)
  ->Js.Array2.map(dbEntryToCharacterInfo)
}

// Get a random selection from an array
let getRandomSelection = (arr: array<'a>, count: int): array<'a> => {
  let shuffled = arr->Js.Array2.copy
  let len = shuffled->Js.Array2.length

  // Fisher-Yates shuffle
  for i in 0 to len - 1 {
    let j = Js.Math.random_int(0, len)
    let temp = shuffled[i]
    shuffled[i] = shuffled[j]
    shuffled[j] = temp
  }

  shuffled->Js.Array2.slice(~start=0, ~end_=Js.Math.min_int(count, len))
}

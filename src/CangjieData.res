// Cangjie 5 character data for Traditional Chinese
// This initial dataset covers basic lessons - can be expanded

open Types

// Helper to create character info
let makeChar = (char: string, code: string, radicals: option<array<string>>): characterInfo => {
  {
    character: char,
    cangjieCode: CangjieUtils.codeToKeys(code),
    radicals: radicals,
  }
}

// Lesson 1: Basic strokes and simple radicals (日月金木水)
let lesson1Characters = [
  makeChar("日", "A", Some(["日"])),
  makeChar("月", "B", Some(["月"])),
  makeChar("金", "C", Some(["金"])),
  makeChar("木", "D", Some(["木"])),
  makeChar("水", "E", Some(["水"])),
  makeChar("明", "AB", Some(["日", "月"])),
  makeChar("林", "DD", Some(["木", "木"])),
  makeChar("森", "DDD", Some(["木", "木", "木"])),
]

// Lesson 2: More basic radicals (火土竹戈十)
let lesson2Characters = [
  makeChar("火", "F", Some(["火"])),
  makeChar("土", "G", Some(["土"])),
  makeChar("竹", "H", Some(["竹"])),
  makeChar("戈", "I", Some(["戈"])),
  makeChar("十", "J", Some(["十"])),
  makeChar("炎", "FF", Some(["火", "火"])),
  makeChar("竺", "HG", Some(["竹", "土"])),
  makeChar("成", "IJ", Some(["戈", "十"])),
]

// Lesson 3: More radicals (大中一弓人)
let lesson3Characters = [
  makeChar("大", "K", Some(["大"])),
  makeChar("中", "L", Some(["中"])),
  makeChar("一", "M", Some(["一"])),
  makeChar("弓", "N", Some(["弓"])),
  makeChar("人", "O", Some(["人"])),
  makeChar("天", "MK", Some(["一", "大"])),
  makeChar("因", "WG", Some(["田", "土"])),
  makeChar("入", "OH", Some(["人", "竹"])),
]

// Lesson 4: Additional radicals (心手口尸廿)
let lesson4Characters = [
  makeChar("心", "P", Some(["心"])),
  makeChar("手", "Q", Some(["手"])),
  makeChar("口", "R", Some(["口"])),
  makeChar("尸", "S", Some(["尸"])),
  makeChar("廿", "T", Some(["廿"])),
  makeChar("思", "PHF", Some(["心", "田"])),
  makeChar("品", "RRR", Some(["口", "口", "口"])),
  makeChar("扣", "QR", Some(["手", "口"])),
]

// Lesson 5: Final basic radicals (山女田難卜)
let lesson5Characters = [
  makeChar("山", "U", Some(["山"])),
  makeChar("女", "V", Some(["女"])),
  makeChar("田", "W", Some(["田"])),
  makeChar("難", "X", Some(["難"])),
  makeChar("卜", "Y", Some(["卜"])),
  makeChar("好", "VND", Some(["女", "子"])),
  makeChar("安", "JV", Some(["宀", "女"])),
  makeChar("岩", "UMR", Some(["山", "石"])),
]

// Common two-character words for practice
let practiceWords1 = [
  makeChar("中", "L", Some(["中"])),
  makeChar("國", "WLMC", Some(["口", "玉"])),
  makeChar("人", "O", Some(["人"])),
  makeChar("民", "OKQ", Some(["人", "口"])),
  makeChar("學", "GOMB", Some(["宀", "子"])),
  makeChar("校", "DYTE", Some(["木", "交"])),
  makeChar("時", "AJKA", Some(["日", "寸"])),
  makeChar("間", "ANAL", Some(["門", "日"])),
]

// Create lesson structure
let makeLesson = (
  id: int,
  title: string,
  description: string,
  lessonType: lessonType,
  keys: array<cangjieKey>,
  chars: array<characterInfo>,
): lesson => {
  {
    id: id,
    title: title,
    description: description,
    lessonType: lessonType,
    introducedKeys: keys,
    characters: chars,
    targetAccuracy: 0.90,
    targetSpeed: Some(30.0),
  }
}

// All lessons
let allLessons = [
  makeLesson(
    1,
    "第一課：基本字根（日月金木水）",
    "學習五個基本字根：日月金木水",
    Introduction,
    [A, B, C, D, E],
    lesson1Characters,
  ),
  makeLesson(
    2,
    "第一課：練習",
    "練習第一課學過的字根",
    Practice,
    [],
    lesson1Characters,
  ),
  makeLesson(
    3,
    "第一課：測驗",
    "測試第一課的掌握程度",
    Test,
    [],
    lesson1Characters,
  ),
  makeLesson(
    4,
    "第二課：基本字根（火土竹戈十）",
    "學習五個基本字根：火土竹戈十",
    Introduction,
    [F, G, H, I, J],
    lesson2Characters,
  ),
  makeLesson(
    5,
    "第二課：練習",
    "練習第二課學過的字根",
    Practice,
    [],
    lesson2Characters,
  ),
  makeLesson(
    6,
    "第二課：測驗",
    "測試第二課的掌握程度",
    Test,
    [],
    lesson2Characters,
  ),
  makeLesson(
    7,
    "第三課：基本字根（大中一弓人）",
    "學習五個基本字根：大中一弓人",
    Introduction,
    [K, L, M, N, O],
    lesson3Characters,
  ),
  makeLesson(
    8,
    "第三課：練習",
    "練習第三課學過的字根",
    Practice,
    [],
    lesson3Characters,
  ),
  makeLesson(
    9,
    "第三課：測驗",
    "測試第三課的掌握程度",
    Test,
    [],
    lesson3Characters,
  ),
  makeLesson(
    10,
    "第四課：基本字根（心手口尸廿）",
    "學習五個基本字根：心手口尸廿",
    Introduction,
    [P, Q, R, S, T],
    lesson4Characters,
  ),
  makeLesson(
    11,
    "第四課：練習",
    "練習第四課學過的字根",
    Practice,
    [],
    lesson4Characters,
  ),
  makeLesson(
    12,
    "第四課：測驗",
    "測試第四課的掌握程度",
    Test,
    [],
    lesson4Characters,
  ),
  makeLesson(
    13,
    "第五課：基本字根（山女田難卜）",
    "學習五個基本字根：山女田難卜",
    Introduction,
    [U, V, W, X, Y],
    lesson5Characters,
  ),
  makeLesson(
    14,
    "第五課：練習",
    "練習第五課學過的字根",
    Practice,
    [],
    lesson5Characters,
  ),
  makeLesson(
    15,
    "第五課：測驗",
    "測試第五課的掌握程度",
    Test,
    [],
    lesson5Characters,
  ),
  makeLesson(
    16,
    "詞語練習（一）",
    "練習常用雙字詞",
    Practice,
    [],
    practiceWords1,
  ),
]

// Get lesson by ID
let getLessonById = (id: int): option<lesson> => {
  allLessons->Js.Array2.find(lesson => lesson.id == id)
}

// Get all lessons
let getAllLessons = (): array<lesson> => allLessons

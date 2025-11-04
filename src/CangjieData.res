// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types

// Helper to create character info
let makeChar = (char: string, code: string, radicals: option<array<string>>): characterInfo => {
  {
    character: char,
    cangjieCode: CangjieUtils.codeToKeys(code),
    radicals: radicals,
  }
}

// Create lesson structure with category
let makeLesson = (
  id: int,
  title: string,
  description: string,
  category: lessonCategory,
  lessonType: lessonType,
  keys: array<cangjieKey>,
  chars: array<characterInfo>,
): lesson => {
  {
    id: id,
    title: title,
    description: description,
    category: category,
    lessonType: lessonType,
    introducedKeys: keys,
    characters: chars,
    targetAccuracy: switch category {
    | Radicals => 0.90
    | CommonWords => 0.85
    | Phrases => 0.80
    | Chengyu => 0.85
    | Sentences => 0.75
    | Custom => 0.80
    },
    targetSpeed: Some(switch category {
    | Radicals => 30.0
    | CommonWords => 25.0
    | Phrases => 20.0
    | Chengyu => 25.0
    | Sentences => 15.0
    | Custom => 20.0
    }),
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

// Lesson 5: Final basic radicals (山女田卜)
let lesson5Characters = [
  makeChar("山", "U", Some(["山"])),
  makeChar("女", "V", Some(["女"])),
  makeChar("田", "W", Some(["田"])),
  makeChar("卜", "Y", Some(["卜"])),
  makeChar("好", "VND", Some(["女", "子"])),
  makeChar("安", "JV", Some(["宀", "女"])),
  makeChar("岩", "UMR", Some(["山", "石"])),
]

// Common word lessons data
let commonWords1 = [
  makeChar("中", "L", None),
  makeChar("國", "WLMC", None),
]

let commonWords2 = [
  makeChar("人", "O", None),
  makeChar("民", "OKQ", None),
]

let commonWords3 = [
  makeChar("時", "AJKA", None),
  makeChar("間", "ANAL", None),
]

let commonWords4 = [
  makeChar("地", "GPD", None),
  makeChar("方", "YSHML", None),
]

let commonWords5 = [
  makeChar("工", "LM", None),
  makeChar("作", "OIHS", None),
]

// Chengyu lesson data
let chengyu1 = [
  makeChar("一", "M", None),
  makeChar("心", "P", None),
  makeChar("一", "M", None),
  makeChar("意", "UJP", None),
]

let chengyu2 = [
  makeChar("人", "O", None),
  makeChar("山", "U", None),
  makeChar("人", "O", None),
  makeChar("海", "ETBQ", None),
]

let chengyu3 = [
  makeChar("日", "A", None),
  makeChar("新", "YSHLB", None),
  makeChar("月", "B", None),
  makeChar("異", "YGWJ", None),
]

// Sentence practice data
let sentence1 = [
  makeChar("你", "ONF", None),
  makeChar("好", "VND", None),
  makeChar("嗎", "RMMR", None),
]

let sentence2 = [
  makeChar("我", "HQO", None),
  makeChar("很", "HPHPM", None),
  makeChar("好", "VND", None),
]

let sentence3 = [
  makeChar("今", "OIN", None),
  makeChar("天", "MK", None),
  makeChar("天", "MK", None),
  makeChar("氣", "ONMVN", None),
  makeChar("很", "HPHPM", None),
  makeChar("好", "VND", None),
]

let sentence4 = [
  makeChar("謝", "YROMR", None),
  makeChar("謝", "YROMR", None),
  makeChar("你", "ONF", None),
]

let sentence5 = [
  makeChar("我", "HQO", None),
  makeChar("喜", "GRHR", None),
  makeChar("歡", "MCNO", None),
  makeChar("學", "GOMB", None),
  makeChar("習", "QMFF", None),
  makeChar("中", "L", None),
  makeChar("文", "YOK", None),
]

let sentence6 = [
  makeChar("學", "GOMB", None),
  makeChar("習", "QMFF", None),
  makeChar("倉", "OIHS", None),
  makeChar("頡", "YKMBC", None),
  makeChar("輸", "XXSJ", None),
  makeChar("入", "OH", None),
  makeChar("法", "EILE", None),
  makeChar("可", "MNIR", None),
  makeChar("以", "VFHS", None),
  makeChar("提", "QNAU", None),
  makeChar("高", "YCOK", None),
  makeChar("打", "QMN", None),
  makeChar("字", "JKND", None),
  makeChar("速", "SMYFD", None),
  makeChar("度", "KJSO", None),
]

let sentence7 = [
  makeChar("中", "L", None),
  makeChar("文", "YOK", None),
  makeChar("是", "AMYO", None),
  makeChar("世", "PT", None),
  makeChar("界", "WLMC", None),
  makeChar("上", "YM", None),
  makeChar("使", "OJLN", None),
  makeChar("用", "BQ", None),
  makeChar("人", "O", None),
  makeChar("數", "OKOK", None),
  makeChar("最", "BTJE", None),
  makeChar("多", "NMQ", None),
  makeChar("的", "WJK", None),
  makeChar("語", "YRNOB", None),
  makeChar("言", "YMCR", None),
]

// Placement test characters (mix of all difficulty levels)
let placementTestChars = [
  makeChar("我", "HQO", None),
  makeChar("你", "ONF", None),
  makeChar("他", "OPD", None),
  makeChar("是", "AMYO", None),
  makeChar("的", "WJK", None),
  makeChar("了", "KSF", None),
  makeChar("在", "GTG", None),
  makeChar("有", "BMM", None),
  makeChar("和", "HDR", None),
  makeChar("到", "SCLN", None),
  makeChar("說", "YRGR", None),
  makeChar("要", "KMW", None),
  makeChar("會", "OWL", None),
  makeChar("能", "OGE", None),
  makeChar("出", "BM", None),
]

// Generate all lessons
let getAllLessons = (): array<lesson> => {
  let basicRadicalLessons = [
    // Lesson 1-3: Radicals Group 1
    makeLesson(1, "第一課：基本字根（日月金木水）", "學習五個基本字根：日月金木水",
      Radicals, Introduction, [A, B, C, D, E], lesson1Characters),
    makeLesson(2, "第一課：練習", "練習第一課學過的字根",
      Radicals, Practice, [], lesson1Characters),
    makeLesson(3, "第一課：測驗", "測試第一課的掌握程度",
      Radicals, Test, [], lesson1Characters),

    // Lesson 4-6: Radicals Group 2
    makeLesson(4, "第二課：基本字根（火土竹戈十）", "學習五個基本字根：火土竹戈十",
      Radicals, Introduction, [F, G, H, I, J], lesson2Characters),
    makeLesson(5, "第二課：練習", "練習第二課學過的字根",
      Radicals, Practice, [], lesson2Characters),
    makeLesson(6, "第二課：測驗", "測試第二課的掌握程度",
      Radicals, Test, [], lesson2Characters),

    // Lesson 7-9: Radicals Group 3
    makeLesson(7, "第三課：基本字根（大中一弓人）", "學習五個基本字根：大中一弓人",
      Radicals, Introduction, [K, L, M, N, O], lesson3Characters),
    makeLesson(8, "第三課：練習", "練習第三課學過的字根",
      Radicals, Practice, [], lesson3Characters),
    makeLesson(9, "第三課：測驗", "測試第三課的掌握程度",
      Radicals, Test, [], lesson3Characters),

    // Lesson 10-12: Radicals Group 4
    makeLesson(10, "第四課：基本字根（心手口尸廿）", "學習五個基本字根：心手口尸廿",
      Radicals, Introduction, [P, Q, R, S, T], lesson4Characters),
    makeLesson(11, "第四課：練習", "練習第四課學過的字根",
      Radicals, Practice, [], lesson4Characters),
    makeLesson(12, "第四課：測驗", "測試第四課的掌握程度",
      Radicals, Test, [], lesson4Characters),

    // Lesson 13-15: Radicals Group 5
    makeLesson(13, "第五課：基本字根（山女田卜）", "學習四個基本字根：山女田卜",
      Radicals, Introduction, [U, V, W, Y], lesson5Characters),
    makeLesson(14, "第五課：練習", "練習第五課學過的字根",
      Radicals, Practice, [], lesson5Characters),
    makeLesson(15, "第五課：測驗", "測試第五課的掌握程度",
      Radicals, Test, [], lesson5Characters),
  ]

  let wordLessons = [
    // Common words
    makeLesson(16, "常用詞語（一）：中國", "練習打「中國」",
      CommonWords, Practice, [], commonWords1),
    makeLesson(17, "常用詞語（二）：人民", "練習打「人民」",
      CommonWords, Practice, [], commonWords2),
    makeLesson(18, "常用詞語（三）：時間", "練習打「時間」",
      CommonWords, Practice, [], commonWords3),
    makeLesson(19, "常用詞語（四）：地方", "練習打「地方」",
      CommonWords, Practice, [], commonWords4),
    makeLesson(20, "常用詞語（五）：工作", "練習打「工作」",
      CommonWords, Practice, [], commonWords5),
    makeLesson(21, "常用詞語測驗", "測試常用詞語的掌握程度",
      CommonWords, Test, [],
      Js.Array2.concat(commonWords1, Js.Array2.concat(commonWords2, Js.Array2.concat(commonWords3, Js.Array2.concat(commonWords4, commonWords5))))),
  ]

  let chengyuLessons = [
    makeLesson(22, "成語（一）：一心一意", "練習打成語「一心一意」",
      Chengyu, Practice, [], chengyu1),
    makeLesson(23, "成語（二）：人山人海", "練習打成語「人山人海」",
      Chengyu, Practice, [], chengyu2),
    makeLesson(24, "成語（三）：日新月異", "練習打成語「日新月異」",
      Chengyu, Practice, [], chengyu3),
    makeLesson(25, "成語綜合測驗", "測試成語的掌握程度",
      Chengyu, Test, [],
      Js.Array2.concat(chengyu1, Js.Array2.concat(chengyu2, chengyu3))),
  ]

  let sentenceLessons = [
    makeLesson(26, "句子練習（一）：你好嗎", "練習簡單問候語",
      Sentences, Practice, [], sentence1),
    makeLesson(27, "句子練習（二）：我很好", "練習簡單回答",
      Sentences, Practice, [], sentence2),
    makeLesson(28, "句子練習（三）：今天天氣很好", "練習描述天氣",
      Sentences, Practice, [], sentence3),
    makeLesson(29, "句子練習（四）：謝謝你", "練習感謝用語",
      Sentences, Practice, [], sentence4),
    makeLesson(30, "句子練習（五）：我喜歡學習中文", "練習表達喜好",
      Sentences, Practice, [], sentence5),
    makeLesson(31, "句子練習（六）：長句練習", "練習較長的句子",
      Sentences, Practice, [], sentence6),
    makeLesson(32, "句子練習（七）：中文語言", "練習描述性長句",
      Sentences, Practice, [], sentence7),
    makeLesson(33, "句子綜合測驗", "測試句子打字能力",
      Sentences, Test, [],
      Js.Array2.concat(
        sentence1,
        Js.Array2.concat(sentence2, Js.Array2.concat(sentence3, sentence4))
      )),
  ]

  // Placement test
  let placementTest = [
    makeLesson(100, "程度測驗", "測試您的倉頡輸入水平",
      Radicals, PlacementTest, [], placementTestChars),
  ]

  // Combine all lessons
  Js.Array2.concat(
    basicRadicalLessons,
    Js.Array2.concat(
      wordLessons,
      Js.Array2.concat(
        chengyuLessons,
        Js.Array2.concat(sentenceLessons, placementTest)
      )
    )
  )
}

// Cache for lessons
let allLessons = getAllLessons()

// Get lesson by ID
let getLessonById = (id: int): option<lesson> => {
  allLessons->Js.Array2.find(lesson => lesson.id == id)
}

// Get lessons by category
let getLessonsByCategory = (category: lessonCategory): array<lesson> => {
  allLessons->Js.Array2.filter(lesson => lesson.category == category)
}

// Get next lesson after completing one
let getNextLesson = (currentId: int): option<lesson> => {
  allLessons->Js.Array2.find(lesson => lesson.id == currentId + 1)
}

// Get placement test
let getPlacementTest = (): option<lesson> => {
  getLessonById(100)
}

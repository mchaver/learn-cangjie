// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types

// Helper to create character info
let makeChar = (
  char: string,
  code: string,
  radicals: option<array<string>>,
  ~hskLevel: option<int>=?,
  ~frequencyRank: option<int>=?,
  (),
): characterInfo => {
  {
    character: char,
    cangjieCode: CangjieUtils.codeToKeys(code),
    radicals: radicals,
    hskLevel: hskLevel,
    frequencyRank: frequencyRank,
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
  ~showCode: bool=false,
  ~allowHints: bool=true,
  ~allowGiveUp: bool=true,
  ~reviewsLessons: array<int>=[],
  (),
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
    showCode: showCode,
    allowHints: allowHints,
    allowGiveUp: allowGiveUp,
    reviewsLessons: reviewsLessons,
  }
}

// Lesson 1: Start with just A (日) and B (月) - TypingClub style
let lesson1Characters = [
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
]

// Lesson 2: Add D (木) - practice A, B, D
let lesson2Characters = [
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
]

// Lesson 3: Add M (一) - practice A, B, D, M
let lesson3Characters = [
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
]

// Lesson 4: Add K (大) - practice A, B, D, M, K
let lesson4Characters = [
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
]

// Lesson 5: Add O (人) - practice A, B, D, M, K, O
let lesson5Characters = [
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
]

// Lesson 6: Add L (中) and R (口)
let lesson6Characters = [
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
]

// Lesson 7: Add J (十) and W (田)
let lesson7Characters = [
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
]

// Lesson 8: Add F (火) and E (水)
let lesson8Characters = [
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
]

// Lesson 9: Add C (金) and G (土)
let lesson9Characters = [
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
]

// Lesson 10: Add H (竹) and I (戈)
let lesson10Characters = [
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
]

// Lesson 11: Add P (心) and Q (手)
let lesson11Characters = [
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
]

// Lesson 12: Add U (山) and V (女)
let lesson12Characters = [
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
]

// Common word lessons data
let commonWords1 = [
  makeChar("中", "L", None, ()),
  makeChar("國", "WLMC", None, ()),
]

let commonWords2 = [
  makeChar("人", "O", None, ()),
  makeChar("民", "OKQ", None, ()),
]

let commonWords3 = [
  makeChar("時", "AJKA", None, ()),
  makeChar("間", "ANAL", None, ()),
]

let commonWords4 = [
  makeChar("地", "GPD", None, ()),
  makeChar("方", "YSHML", None, ()),
]

let commonWords5 = [
  makeChar("工", "LM", None, ()),
  makeChar("作", "OIHS", None, ()),
]

// Chengyu lesson data
let chengyu1 = [
  makeChar("一", "M", None, ()),
  makeChar("心", "P", None, ()),
  makeChar("一", "M", None, ()),
  makeChar("意", "UJP", None, ()),
]

let chengyu2 = [
  makeChar("人", "O", None, ()),
  makeChar("山", "U", None, ()),
  makeChar("人", "O", None, ()),
  makeChar("海", "ETBQ", None, ()),
]

let chengyu3 = [
  makeChar("日", "A", None, ()),
  makeChar("新", "YSHLB", None, ()),
  makeChar("月", "B", None, ()),
  makeChar("異", "YGWJ", None, ()),
]

// Sentence practice data
let sentence1 = [
  makeChar("你", "ONF", None, ()),
  makeChar("好", "VND", None, ()),
  makeChar("嗎", "RMMR", None, ()),
]

let sentence2 = [
  makeChar("我", "HQO", None, ()),
  makeChar("很", "HPHPM", None, ()),
  makeChar("好", "VND", None, ()),
]

let sentence3 = [
  makeChar("今", "OIN", None, ()),
  makeChar("天", "MK", None, ()),
  makeChar("天", "MK", None, ()),
  makeChar("氣", "ONMVN", None, ()),
  makeChar("很", "HPHPM", None, ()),
  makeChar("好", "VND", None, ()),
]

let sentence4 = [
  makeChar("謝", "YROMR", None, ()),
  makeChar("謝", "YROMR", None, ()),
  makeChar("你", "ONF", None, ()),
]

let sentence5 = [
  makeChar("我", "HQO", None, ()),
  makeChar("喜", "GRHR", None, ()),
  makeChar("歡", "MCNO", None, ()),
  makeChar("學", "GOMB", None, ()),
  makeChar("習", "QMFF", None, ()),
  makeChar("中", "L", None, ()),
  makeChar("文", "YOK", None, ()),
]

let sentence6 = [
  makeChar("學", "GOMB", None, ()),
  makeChar("習", "QMFF", None, ()),
  makeChar("倉", "OIHS", None, ()),
  makeChar("頡", "YKMBC", None, ()),
  makeChar("輸", "XXSJ", None, ()),
  makeChar("入", "OH", None, ()),
  makeChar("法", "EILE", None, ()),
  makeChar("可", "MNIR", None, ()),
  makeChar("以", "VFHS", None, ()),
  makeChar("提", "QNAU", None, ()),
  makeChar("高", "YCOK", None, ()),
  makeChar("打", "QMN", None, ()),
  makeChar("字", "JKND", None, ()),
  makeChar("速", "SMYFD", None, ()),
  makeChar("度", "KJSO", None, ()),
]

let sentence7 = [
  makeChar("中", "L", None, ()),
  makeChar("文", "YOK", None, ()),
  makeChar("是", "AMYO", None, ()),
  makeChar("世", "PT", None, ()),
  makeChar("界", "WLMC", None, ()),
  makeChar("上", "YM", None, ()),
  makeChar("使", "OJLN", None, ()),
  makeChar("用", "BQ", None, ()),
  makeChar("人", "O", None, ()),
  makeChar("數", "OKOK", None, ()),
  makeChar("最", "BTJE", None, ()),
  makeChar("多", "NMQ", None, ()),
  makeChar("的", "WJK", None, ()),
  makeChar("語", "YRNOB", None, ()),
  makeChar("言", "YMCR", None, ()),
]

// Placement test characters (mix of all difficulty levels)
let placementTestChars = [
  makeChar("我", "HQO", None, ()),
  makeChar("你", "ONF", None, ()),
  makeChar("他", "OPD", None, ()),
  makeChar("是", "AMYO", None, ()),
  makeChar("的", "WJK", None, ()),
  makeChar("了", "KSF", None, ()),
  makeChar("在", "GTG", None, ()),
  makeChar("有", "BMM", None, ()),
  makeChar("和", "HDR", None, ()),
  makeChar("到", "SCLN", None, ()),
  makeChar("說", "YRGR", None, ()),
  makeChar("要", "KMW", None, ()),
  makeChar("會", "OWL", None, ()),
  makeChar("能", "OGE", None, ()),
  makeChar("出", "BM", None, ()),
]

// Generate all lessons
let getAllLessons = (): array<lesson> => {
  let basicRadicalLessons = [
    // Lesson 1: Start with A (日) and B (月) only
    makeLesson(1, "第一課：日月", "學習 A(日) 和 B(月)",
      Radicals, Introduction, [A, B], lesson1Characters, ()),

    // Lesson 2: Add D (木)
    makeLesson(2, "第二課：木", "學習 D(木) 並複習日月",
      Radicals, Introduction, [D], lesson2Characters, ()),

    // Lesson 3: Add M (一)
    makeLesson(3, "第三課：一", "學習 M(一) 並複習",
      Radicals, Introduction, [M], lesson3Characters, ()),

    // Lesson 4: Add K (大)
    makeLesson(4, "第四課：大", "學習 K(大) 並複習",
      Radicals, Introduction, [K], lesson4Characters, ()),

    // Lesson 5: Add O (人)
    makeLesson(5, "第五課：人", "學習 O(人) 並複習",
      Radicals, Introduction, [O], lesson5Characters, ()),

    // Lesson 6: Add L (中) and R (口)
    makeLesson(6, "第六課：中口", "學習 L(中) 和 R(口)",
      Radicals, Introduction, [L, R], lesson6Characters, ()),

    // Lesson 7: Add J (十) and W (田)
    makeLesson(7, "第七課：十田", "學習 J(十) 和 W(田)",
      Radicals, Introduction, [J, W], lesson7Characters, ()),

    // Lesson 8: Add F (火) and E (水)
    makeLesson(8, "第八課：火水", "學習 F(火) 和 E(水)",
      Radicals, Introduction, [F, E], lesson8Characters, ()),

    // Lesson 9: Add C (金) and G (土)
    makeLesson(9, "第九課：金土", "學習 C(金) 和 G(土)",
      Radicals, Introduction, [C, G], lesson9Characters, ()),

    // Lesson 10: Add H (竹) and I (戈)
    makeLesson(10, "第十課：竹戈", "學習 H(竹) 和 I(戈)",
      Radicals, Introduction, [H, I], lesson10Characters, ()),

    // Lesson 11: Add P (心) and Q (手)
    makeLesson(11, "第十一課：心手", "學習 P(心) 和 Q(手)",
      Radicals, Introduction, [P, Q], lesson11Characters, ()),

    // Lesson 12: Add U (山) and V (女)
    makeLesson(12, "第十二課：山女", "學習 U(山) 和 V(女)",
      Radicals, Introduction, [U, V], lesson12Characters, ()),
  ]

  let wordLessons = [
    // Common words
    makeLesson(16, "常用詞語（一）：中國", "練習打「中國」",
      CommonWords, Practice, [], commonWords1, ()),
    makeLesson(17, "常用詞語（二）：人民", "練習打「人民」",
      CommonWords, Practice, [], commonWords2, ()),
    makeLesson(18, "常用詞語（三）：時間", "練習打「時間」",
      CommonWords, Practice, [], commonWords3, ()),
    makeLesson(19, "常用詞語（四）：地方", "練習打「地方」",
      CommonWords, Practice, [], commonWords4, ()),
    makeLesson(20, "常用詞語（五）：工作", "練習打「工作」",
      CommonWords, Practice, [], commonWords5, ()),
    makeLesson(21, "常用詞語測驗", "測試常用詞語的掌握程度",
      CommonWords, Test, [],
      Js.Array2.concat(commonWords1, Js.Array2.concat(commonWords2, Js.Array2.concat(commonWords3, Js.Array2.concat(commonWords4, commonWords5)))), ()),
  ]

  let chengyuLessons = [
    makeLesson(22, "成語（一）：一心一意", "練習打成語「一心一意」",
      Chengyu, Practice, [], chengyu1, ()),
    makeLesson(23, "成語（二）：人山人海", "練習打成語「人山人海」",
      Chengyu, Practice, [], chengyu2, ()),
    makeLesson(24, "成語（三）：日新月異", "練習打成語「日新月異」",
      Chengyu, Practice, [], chengyu3, ()),
    makeLesson(25, "成語綜合測驗", "測試成語的掌握程度",
      Chengyu, Test, [],
      Js.Array2.concat(chengyu1, Js.Array2.concat(chengyu2, chengyu3)), ()),
  ]

  let sentenceLessons = [
    makeLesson(26, "句子練習（一）：你好嗎", "練習簡單問候語",
      Sentences, Practice, [], sentence1, ()),
    makeLesson(27, "句子練習（二）：我很好", "練習簡單回答",
      Sentences, Practice, [], sentence2, ()),
    makeLesson(28, "句子練習（三）：今天天氣很好", "練習描述天氣",
      Sentences, Practice, [], sentence3, ()),
    makeLesson(29, "句子練習（四）：謝謝你", "練習感謝用語",
      Sentences, Practice, [], sentence4, ()),
    makeLesson(30, "句子練習（五）：我喜歡學習中文", "練習表達喜好",
      Sentences, Practice, [], sentence5, ()),
    makeLesson(31, "句子練習（六）：長句練習", "練習較長的句子",
      Sentences, Practice, [], sentence6, ()),
    makeLesson(32, "句子練習（七）：中文語言", "練習描述性長句",
      Sentences, Practice, [], sentence7, ()),
    makeLesson(33, "句子綜合測驗", "測試句子打字能力",
      Sentences, Test, [],
      Js.Array2.concat(
        sentence1,
        Js.Array2.concat(sentence2, Js.Array2.concat(sentence3, sentence4))
      ), ()),
  ]

  // Placement test
  let placementTest = [
    makeLesson(100, "程度測驗", "測試您的倉頡輸入水平",
      Radicals, PlacementTest, [], placementTestChars, ()),
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

// Create a randomized review lesson from completed lessons
let createReviewLesson = (completedLessonIds: array<int>, characterCount: int): option<lesson> => {
  // Collect all characters from completed lessons
  let allChars = completedLessonIds
    ->Js.Array2.map(id => getLessonById(id))
    ->Js.Array2.filter(Belt.Option.isSome)
    ->Js.Array2.map(Belt.Option.getExn)
    ->Js.Array2.reduce((acc, lesson) => {
      Js.Array2.concat(acc, lesson.characters)
    }, [])

  if allChars->Js.Array2.length == 0 {
    None
  } else {
    // Shuffle and take requested number of characters
    let shuffled = CangjieUtils.shuffleArray(allChars)
    let selected = shuffled->Js.Array2.slice(~start=0, ~end_=Js.Math.min_int(characterCount, shuffled->Js.Array2.length))

    Some({
      id: 9000, // Special ID for review lessons
      title: "隨機複習",
      description: `複習 ${Belt.Int.toString(selected->Js.Array2.length)} 個已學過的字`,
      category: Custom,
      lessonType: Review,
      introducedKeys: [],
      characters: selected,
      targetAccuracy: 0.85,
      targetSpeed: Some(25.0),
      showCode: false,
      allowHints: false,
      allowGiveUp: true,
      reviewsLessons: completedLessonIds,
    })
  }
}

// Create a timed challenge lesson
let createTimedChallenge = (completedLessonIds: array<int>, durationSeconds: int): option<lesson> => {
  // Collect all characters from completed lessons
  let allChars = completedLessonIds
    ->Js.Array2.map(id => getLessonById(id))
    ->Js.Array2.filter(Belt.Option.isSome)
    ->Js.Array2.map(Belt.Option.getExn)
    ->Js.Array2.reduce((acc, lesson) => {
      Js.Array2.concat(acc, lesson.characters)
    }, [])

  if allChars->Js.Array2.length == 0 {
    None
  } else {
    // Create a large pool of characters (shuffle and repeat)
    let poolSize = 100

    // Repeat characters to create a larger pool
    let rec buildPool = (pool: array<characterInfo>, remaining: int): array<characterInfo> => {
      if remaining <= 0 {
        pool
      } else {
        let newChars = CangjieUtils.shuffleArray(allChars)
        let needed = Js.Math.min_int(remaining, newChars->Js.Array2.length)
        let toAdd = newChars->Js.Array2.slice(~start=0, ~end_=needed)
        buildPool(Js.Array2.concat(pool, toAdd), remaining - needed)
      }
    }

    let challengeChars = buildPool([], poolSize)

    Some({
      id: 9001, // Special ID for timed challenges
      title: `限時挑戰 (${Belt.Int.toString(durationSeconds)}秒)`,
      description: `在 ${Belt.Int.toString(durationSeconds)} 秒內盡可能打出更多字`,
      category: Custom,
      lessonType: TimedChallenge,
      introducedKeys: [],
      characters: challengeChars,
      targetAccuracy: 0.80,
      targetSpeed: Some(30.0),
      showCode: false,
      allowHints: false,
      allowGiveUp: false,
      reviewsLessons: [],
    })
  }
}

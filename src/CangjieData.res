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
    | Radicals => 0.80
    | CommonWords => 0.80
    | Phrases => 0.80
    | Chengyu => 0.80
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

// Lesson 1: 日月 - Learn A (日) and B (月)
// ~20 characters: intro with code visible, then practice without
let lesson1Characters = [
  // Introduce 日
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  // Introduce 月
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  // Combine them
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  // Practice mix
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  // More reinforcement
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
]

// Lesson 2: 木 - Learn D (木), review 日月
let lesson2Characters = [
  // Introduce 木
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  // Combine 木木
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  // Review previous + new
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
]

// Lesson 3: 一大 - Learn M (一) and K (大)
let lesson3Characters = [
  // Introduce 一
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  // Introduce 大
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  // Combine them
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  // Practice mix
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
]

// Lesson 4: 人 - Learn O (人), review previous radicals
let lesson4Characters = [
  // Introduce 人
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  // Practice mix with review
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
]

// Lesson 5: 中口 - Learn L (中) and R (口)
let lesson5Characters = [
  // Introduce 中
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  // Introduce 口
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  // Practice mix
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
]

// Lesson 6: 十田 - Learn J (十) and W (田)
let lesson6Characters = [
  // Introduce 十
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  // Introduce 田
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  // Practice mix
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
]

// Lesson 7: 火水 - Learn F (火) and E (水)
let lesson7Characters = [
  // Introduce 火
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  // Introduce 水
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  // Combine 火火
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  // Practice mix
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
]

// Lesson 8: 金土 - Learn C (金) and G (土)
let lesson8Characters = [
  // Introduce 金
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  // Introduce 土
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  // Practice mix (five elements: 金木水火土)
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
]

// Lesson 9: 竹戈 - Learn H (竹) and I (戈)
let lesson9Characters = [
  // Introduce 竹
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  // Introduce 戈
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  // Combinations
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  // Practice mix
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
]

// Lesson 10: 心手 - Learn P (心) and Q (手)
let lesson10Characters = [
  // Introduce 心
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  // Introduce 手
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  // Combinations
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  // Practice mix
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
]

// Lesson 11: 山女 - Learn U (山) and V (女)
let lesson11Characters = [
  // Introduce 山
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  // Introduce 女
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  // Practice mix
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
]

// Application lessons - multi-character words using learned radicals

// Application 1: After Set 1 (日月木一大)
let application1Characters = [
  makeChar("明", "AB", Some(["日", "月"]), ()), // bright/tomorrow
  makeChar("天", "MK", Some(["一", "大"]), ()), // sky/day
  makeChar("林", "DD", Some(["木", "木"]), ()), // forest
  makeChar("朋", "BB", Some(["月", "月"]), ()), // friend
  makeChar("旦", "AM", Some(["日", "一"]), ()), // dawn/morning
]

// Application 2: After Set 2 (人中口十田)
let application2Characters = [
  makeChar("同", "BMR", Some(["月", "一", "口"]), ()), // same
  makeChar("右", "KR", Some(["大", "口"]), ()), // right
  makeChar("石", "MR", Some(["一", "口"]), ()), // stone
  makeChar("呆", "RD", Some(["口", "木"]), ()), // dull/stay
  makeChar("个", "OL", Some(["人", "中"]), ()), // MW/individual
]

// Application 3: After Set 3 (火水金土竹戈)
let application3Characters = [
  makeChar("早", "AJ", Some(["日", "十"]), ()), // early/morning
  makeChar("東", "DW", Some(["木", "田"]), ()), // east
  makeChar("末", "DJ", Some(["木", "十"]), ()), // end
  makeChar("友", "KE", Some(["大", "水"]), ()), // friend
  makeChar("炎", "FF", Some(["火", "火"]), ()), // flame/inflammation
  makeChar("杰", "DF", Some(["木", "火"]), ()), // outstanding/hero
  makeChar("汉", "EE", Some(["水", "水"]), ()), // Han Chinese
  makeChar("灰", "KF", Some(["大", "火"]), ()), // ash/grey
  makeChar("由", "LW", Some(["中", "田"]), ()), // by/from/reason
  makeChar("支", "JE", Some(["十", "水"]), ()), // support/branch
  makeChar("去", "GI", Some(["土", "戈"]), ()), // go
  makeChar("公", "CI", Some(["金", "戈"]), ()), // public/male
  makeChar("才", "DH", Some(["木", "竹"]), ()), // talent
  makeChar("白", "HA", Some(["竹", "日"]), ()), // white
  makeChar("千", "HJ", Some(["竹", "十"]), ()), // thousand
  makeChar("八", "HO", Some(["竹", "人"]), ()), // eight
  makeChar("禾", "HD", Some(["竹", "木"]), ()), // grain/rice
  makeChar("少", "FH", Some(["火", "竹"]), ()), // few/little
  makeChar("寸", "DI", Some(["木", "戈"]), ()), // inch/small
]

// Application 4: After Set 4 (心手山女)
let application4Characters = [
  // Will add more application characters as needed
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("同", "BMR", Some(["月", "一", "口"]), ()),
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
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
    // SET 1: Lessons 1-4
    // Lesson 1: Content - 日月
    makeLesson(1, "第一課：日月 (內容)", "學習 A(日) 和 B(月)",
      Radicals, Practice, [A, B], lesson1Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 2: Content - 木
    makeLesson(2, "第二課：木 (內容)", "學習 D(木)",
      Radicals, Practice, [D], lesson2Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 3: Content - 一大
    makeLesson(3, "第三課：一大 (內容)", "學習 M(一) 和 K(大)",
      Radicals, Practice, [M, K], lesson3Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 4: Content Review - 日月木一大
    makeLesson(4, "內容複習：日月木一大", "複習第一到第三課",
      Radicals, Review, [A, B, D, M, K],
      Js.Array2.concat(lesson1Characters, Js.Array2.concat(lesson2Characters, lesson3Characters)),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3], ()),

    // SET 2: Lessons 5-9
    // Lesson 5: Content - 人
    makeLesson(5, "第四課：人 (內容)", "學習 O(人)",
      Radicals, Practice, [O], lesson4Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 6: Content - 中口
    makeLesson(6, "第五課：中口 (內容)", "學習 L(中) 和 R(口)",
      Radicals, Practice, [L, R], lesson5Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 7: Content - 十田
    makeLesson(7, "第六課：十田 (內容)", "學習 J(十) 和 W(田)",
      Radicals, Practice, [J, W], lesson6Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 8: Content Review - 人中口十田
    makeLesson(8, "內容複習：人中口十田", "複習第四到第六課",
      Radicals, Review, [O, L, R, J, W],
      Js.Array2.concat(lesson4Characters, Js.Array2.concat(lesson5Characters, lesson6Characters)),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[5, 6, 7], ()),

    // Lesson 9: Mixed Review - all previous + application chars
    makeLesson(9, "綜合練習：基礎 + 應用", "練習所有已學字符及應用字",
      Radicals, MixedReview, [A, B, D, M, K, O, L, R, J, W],
      Js.Array2.concat(
        Js.Array2.concat(lesson1Characters, Js.Array2.concat(lesson2Characters, lesson3Characters)),
        Js.Array2.concat(
          Js.Array2.concat(lesson4Characters, Js.Array2.concat(lesson5Characters, lesson6Characters)),
          application1Characters
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 5, 6, 7], ()),

    // SET 3: Lessons 10-14
    // Lesson 10: Content - 火水
    makeLesson(10, "第七課：火水 (內容)", "學習 F(火) 和 E(水)",
      Radicals, Practice, [F, E], lesson7Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 11: Content - 金土
    makeLesson(11, "第八課：金土 (內容)", "學習 C(金) 和 G(土)",
      Radicals, Practice, [C, G], lesson8Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 12: Content - 竹戈
    makeLesson(12, "第九課：竹戈 (內容)", "學習 H(竹) 和 I(戈)",
      Radicals, Practice, [H, I], lesson9Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 13: Content Review - 火水金土竹戈
    makeLesson(13, "內容複習：火水金土竹戈", "複習第七到第九課",
      Radicals, Review, [F, E, C, G, H, I],
      Js.Array2.concat(lesson7Characters, Js.Array2.concat(lesson8Characters, lesson9Characters)),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[10, 11, 12], ()),

    // Lesson 14: Mixed Review - all previous + application chars
    makeLesson(14, "綜合練習：擴展應用", "練習所有已學字符及擴展應用字",
      Radicals, MixedReview, [A, B, D, M, K, O, L, R, J, W, F, E, C, G, H, I],
      Js.Array2.concat(
        Js.Array2.concat(lesson1Characters, Js.Array2.concat(lesson2Characters, Js.Array2.concat(lesson3Characters, Js.Array2.concat(lesson4Characters, Js.Array2.concat(lesson5Characters, Js.Array2.concat(lesson6Characters, Js.Array2.concat(lesson7Characters, Js.Array2.concat(lesson8Characters, lesson9Characters)))))))),
        Js.Array2.concat(application1Characters, Js.Array2.concat(application2Characters, application3Characters))
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 5, 6, 7, 10, 11, 12], ()),

    // SET 4: Lessons 15-18
    // Lesson 15: Content - 心手
    makeLesson(15, "第十課：心手 (內容)", "學習 P(心) 和 Q(手)",
      Radicals, Practice, [P, Q], lesson10Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 16: Content - 山女
    makeLesson(16, "第十一課：山女 (內容)", "學習 U(山) 和 V(女)",
      Radicals, Practice, [U, V], lesson11Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 17: Content Review - 心手山女
    makeLesson(17, "內容複習：心手山女", "複習第十到第十一課",
      Radicals, Review, [P, Q, U, V],
      Js.Array2.concat(lesson10Characters, lesson11Characters),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[15, 16], ()),

    // Lesson 18: Mixed Review - all radicals + all application chars
    makeLesson(18, "綜合練習：全面掌握", "練習所有已學字符及全部應用字",
      Radicals, MixedReview, [A, B, D, M, K, O, L, R, J, W, F, E, C, G, H, I, P, Q, U, V],
      Js.Array2.concat(
        Js.Array2.concat(lesson1Characters, Js.Array2.concat(lesson2Characters, Js.Array2.concat(lesson3Characters, Js.Array2.concat(lesson4Characters, Js.Array2.concat(lesson5Characters, Js.Array2.concat(lesson6Characters, Js.Array2.concat(lesson7Characters, Js.Array2.concat(lesson8Characters, Js.Array2.concat(lesson9Characters, Js.Array2.concat(lesson10Characters, lesson11Characters)))))))))),
        Js.Array2.concat(application1Characters, Js.Array2.concat(application2Characters, Js.Array2.concat(application3Characters, application4Characters)))
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 5, 6, 7, 10, 11, 12, 15, 16], ()),
  ]

  let wordLessons = [
    // Common words
    makeLesson(19, "常用詞語（一）：中國", "練習打「中國」",
      CommonWords, Practice, [], commonWords1, ()),
    makeLesson(20, "常用詞語（二）：人民", "練習打「人民」",
      CommonWords, Practice, [], commonWords2, ()),
    makeLesson(21, "常用詞語（三）：時間", "練習打「時間」",
      CommonWords, Practice, [], commonWords3, ()),
    makeLesson(22, "常用詞語（四）：地方", "練習打「地方」",
      CommonWords, Practice, [], commonWords4, ()),
    makeLesson(23, "常用詞語（五）：工作", "練習打「工作」",
      CommonWords, Practice, [], commonWords5, ()),
    makeLesson(24, "常用詞語測驗", "測試常用詞語的掌握程度",
      CommonWords, Test, [],
      Js.Array2.concat(commonWords1, Js.Array2.concat(commonWords2, Js.Array2.concat(commonWords3, Js.Array2.concat(commonWords4, commonWords5)))), ()),
  ]

  let chengyuLessons = [
    makeLesson(25, "成語（一）：一心一意", "練習打成語「一心一意」",
      Chengyu, Practice, [], chengyu1, ()),
    makeLesson(26, "成語（二）：人山人海", "練習打成語「人山人海」",
      Chengyu, Practice, [], chengyu2, ()),
    makeLesson(27, "成語（三）：日新月異", "練習打成語「日新月異」",
      Chengyu, Practice, [], chengyu3, ()),
    makeLesson(28, "成語綜合測驗", "測試成語的掌握程度",
      Chengyu, Test, [],
      Js.Array2.concat(chengyu1, Js.Array2.concat(chengyu2, chengyu3)), ()),
  ]

  let sentenceLessons = [
    makeLesson(29, "句子練習（一）：你好嗎", "練習簡單問候語",
      Sentences, Practice, [], sentence1, ()),
    makeLesson(30, "句子練習（二）：我很好", "練習簡單回答",
      Sentences, Practice, [], sentence2, ()),
    makeLesson(31, "句子練習（三）：今天天氣很好", "練習描述天氣",
      Sentences, Practice, [], sentence3, ()),
    makeLesson(32, "句子練習（四）：謝謝你", "練習感謝用語",
      Sentences, Practice, [], sentence4, ()),
    makeLesson(33, "句子練習（五）：我喜歡學習中文", "練習表達喜好",
      Sentences, Practice, [], sentence5, ()),
    makeLesson(34, "句子練習（六）：長句練習", "練習較長的句子",
      Sentences, Practice, [], sentence6, ()),
    makeLesson(35, "句子練習（七）：中文語言", "練習描述性長句",
      Sentences, Practice, [], sentence7, ()),
    makeLesson(36, "句子綜合測驗", "測試句子打字能力",
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

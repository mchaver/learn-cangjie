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

// Create lesson structure with section and category
let makeLesson = (
  id: int,
  title: string,
  description: string,
  section: lessonSection,
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
    section: section,
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

// PHILOSOPHY (哲理類) - Lessons 1-7
// Lesson 1: 日 - Learn A (日)
let lesson1Characters = [
  // Introduce 日
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  // Characters with 日
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
  // Practice mix
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
]

// Lesson 2: 月 - Learn B (月)
let lesson2Characters = [
  // Introduce 月
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  // Characters with 月
  makeChar("朋", "BB", Some(["月", "月"]), ()),
  makeChar("朋", "BB", Some(["月", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("有", "KB", Some(["大", "月"]), ()),
  makeChar("有", "KB", Some(["大", "月"]), ()),
  // Practice mix
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("朋", "BB", Some(["月", "月"]), ()),
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("月", "B", Some(["月"]), ()),
  makeChar("有", "KB", Some(["大", "月"]), ()),
  makeChar("日", "A", Some(["日"]), ()),
]

// Lesson 3: 金 - Learn C (金)
let lesson3Characters = [
  // Introduce 金
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  // Characters with 金
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("分", "CSH", Some(["金", "尸", "竹"]), ()),
  makeChar("分", "CSH", Some(["金", "尸", "竹"]), ()),
  // Practice mix
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("分", "CSH", Some(["金", "尸", "竹"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
]

// Lesson 4: 木 - Learn D (木)
let lesson4Characters = [
  // Introduce 木
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  // Characters with 木
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("末", "DJ", Some(["木", "十"]), ()),
  makeChar("末", "DJ", Some(["木", "十"]), ()),
  // Practice mix
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("末", "DJ", Some(["木", "十"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
]

// Lesson 5: 水 - Learn E (水)
let lesson5Characters = [
  // Introduce 水
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  // Characters with 水
  makeChar("汉", "EE", Some(["水", "水"]), ()),
  makeChar("汉", "EE", Some(["水", "水"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
  // Practice mix
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("汉", "EE", Some(["水", "水"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
]

// Lesson 6: 火 - Learn F (火)
let lesson6Characters = [
  // Introduce 火
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  // Characters with 火
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("杰", "DF", Some(["木", "火"]), ()),
  makeChar("杰", "DF", Some(["木", "火"]), ()),
  makeChar("灰", "KF", Some(["大", "火"]), ()),
  makeChar("灰", "KF", Some(["大", "火"]), ()),
  makeChar("少", "FH", Some(["火", "竹"]), ()),
  makeChar("少", "FH", Some(["火", "竹"]), ()),
  // Practice mix
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("杰", "DF", Some(["木", "火"]), ()),
]

// Lesson 7: 土 - Learn G (土)
let lesson7Characters = [
  // Introduce 土
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
  // Characters with 土
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  // Practice mix with five elements review
  makeChar("土", "G", Some(["土"]), ()),
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("金", "C", Some(["金"]), ()),
  makeChar("木", "D", Some(["木"]), ()),
  makeChar("水", "E", Some(["水"]), ()),
  makeChar("火", "F", Some(["火"]), ()),
  makeChar("土", "G", Some(["土"]), ()),
]

// STROKES (筆畫類) - Lessons 8-14
// Lesson 8: 竹 - Learn H (竹)
let lesson8Characters = [
  // Introduce 竹
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  makeChar("竹", "H", Some(["竹"]), ()),
  // Characters with 竹
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("竺", "HG", Some(["竹", "土"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
  makeChar("白", "HA", Some(["竹", "日"]), ()),
  makeChar("千", "HJ", Some(["竹", "十"]), ()),
  makeChar("千", "HJ", Some(["竹", "十"]), ()),
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("禾", "HD", Some(["竹", "木"]), ()),
  makeChar("禾", "HD", Some(["竹", "木"]), ()),
  makeChar("少", "FH", Some(["火", "竹"]), ()),
  makeChar("少", "FH", Some(["火", "竹"]), ()),
]

// Lesson 9: 戈 - Learn I (戈)
let lesson9Characters = [
  // Introduce 戈
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
  // Characters with 戈
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("公", "CI", Some(["金", "戈"]), ()),
  makeChar("寸", "DI", Some(["木", "戈"]), ()),
  makeChar("寸", "DI", Some(["木", "戈"]), ()),
  // Practice mix
  makeChar("戈", "I", Some(["戈"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("去", "GI", Some(["土", "戈"]), ()),
  makeChar("戈", "I", Some(["戈"]), ()),
]

// Lesson 10: 十 - Learn J (十)
let lesson10Characters = [
  // Introduce 十
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
  // Characters with 十
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("早", "AJ", Some(["日", "十"]), ()),
  makeChar("末", "DJ", Some(["木", "十"]), ()),
  makeChar("末", "DJ", Some(["木", "十"]), ()),
  makeChar("千", "HJ", Some(["竹", "十"]), ()),
  makeChar("千", "HJ", Some(["竹", "十"]), ()),
  makeChar("支", "JE", Some(["十", "水"]), ()),
  makeChar("支", "JE", Some(["十", "水"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("成", "IJ", Some(["戈", "十"]), ()),
  makeChar("十", "J", Some(["十"]), ()),
]

// Lesson 11: 大 - Learn K (大)
let lesson11Characters = [
  // Introduce 大
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
  // Characters with 大
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
  makeChar("友", "KE", Some(["大", "水"]), ()),
  makeChar("灰", "KF", Some(["大", "火"]), ()),
  makeChar("灰", "KF", Some(["大", "火"]), ()),
  makeChar("有", "KB", Some(["大", "月"]), ()),
  makeChar("有", "KB", Some(["大", "月"]), ()),
  makeChar("右", "KR", Some(["大", "口"]), ()),
  makeChar("右", "KR", Some(["大", "口"]), ()),
  makeChar("大", "K", Some(["大"]), ()),
]

// Lesson 12: 中 - Learn L (中)
let lesson12Characters = [
  // Introduce 中
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  // Characters with 中
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  // Practice mix
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("中", "L", Some(["中"]), ()),
]

// Lesson 13: 一 - Learn M (一)
let lesson13Characters = [
  // Introduce 一
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  // Characters with 一
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("石", "MR", Some(["一", "口"]), ()),
  makeChar("石", "MR", Some(["一", "口"]), ()),
  // Practice mix
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("天", "MK", Some(["一", "大"]), ()),
  makeChar("旦", "AM", Some(["日", "一"]), ()),
  makeChar("一", "M", Some(["一"]), ()),
  makeChar("石", "MR", Some(["一", "口"]), ()),
]

// Lesson 14: 弓 - Learn N (弓)
let lesson14Characters = [
  // Introduce 弓
  makeChar("弓", "N", Some(["弓"]), ()),
  makeChar("弓", "N", Some(["弓"]), ()),
  makeChar("弓", "N", Some(["弓"]), ()),
  makeChar("弓", "N", Some(["弓"]), ()),
  makeChar("弓", "N", Some(["弓"]), ()),
  // Characters with 弓
  makeChar("引", "NL", Some(["弓", "中"]), ()),
  makeChar("引", "NL", Some(["弓", "中"]), ()),
  makeChar("弱", "NN", Some(["弓", "弓"]), ()),
  makeChar("弱", "NN", Some(["弓", "弓"]), ()),
  makeChar("強", "NR", Some(["弓", "口"]), ()),
  makeChar("強", "NR", Some(["弓", "口"]), ()),
  // Practice mix
  makeChar("弓", "N", Some(["弓"]), ()),
  makeChar("引", "NL", Some(["弓", "中"]), ()),
  makeChar("弱", "NN", Some(["弓", "弓"]), ()),
  makeChar("弓", "N", Some(["弓"]), ()),
]

// BODY PARTS (人體類) - Lessons 15-18
// Lesson 15: 人 - Learn O (人)
let lesson15Characters = [
  // Introduce 人
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  // Characters with 人
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("從", "OO", Some(["人", "人"]), ()),
  makeChar("從", "OO", Some(["人", "人"]), ()),
  // Practice mix
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("个", "OL", Some(["人", "中"]), ()),
  makeChar("人", "O", Some(["人"]), ()),
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("從", "OO", Some(["人", "人"]), ()),
]

// Lesson 16: 心 - Learn P (心)
let lesson16Characters = [
  // Introduce 心
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  // Characters with 心
  makeChar("必", "HP", Some(["竹", "心"]), ()),
  makeChar("必", "HP", Some(["竹", "心"]), ()),
  // Practice mix
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("必", "HP", Some(["竹", "心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("必", "HP", Some(["竹", "心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
  makeChar("心", "P", Some(["心"]), ()),
]

// Lesson 17: 手 - Learn Q (手)
let lesson17Characters = [
  // Introduce 手
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  // Characters with 手
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  // Practice mix
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
  makeChar("手", "Q", Some(["手"]), ()),
]

// Lesson 18: 口 - Learn R (口)
let lesson18Characters = [
  // Introduce 口
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  makeChar("口", "R", Some(["口"]), ()),
  // Characters with 口
  makeChar("石", "MR", Some(["一", "口"]), ()),
  makeChar("石", "MR", Some(["一", "口"]), ()),
  makeChar("呆", "RD", Some(["口", "木"]), ()),
  makeChar("呆", "RD", Some(["口", "木"]), ()),
  makeChar("右", "KR", Some(["大", "口"]), ()),
  makeChar("右", "KR", Some(["大", "口"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("扣", "QR", Some(["手", "口"]), ()),
  makeChar("同", "BMR", Some(["月", "一", "口"]), ()),
  makeChar("同", "BMR", Some(["月", "一", "口"]), ()),
]

// CHARACTER SHAPES (字形類) - Lessons 19-24
// Lesson 19: 尸 - Learn S (尸)
let lesson19Characters = [
  // Introduce 尸
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尸", "S", Some(["尸"]), ()),
  // Characters with 尸
  makeChar("尺", "SI", Some(["尸", "戈"]), ()),
  makeChar("尺", "SI", Some(["尸", "戈"]), ()),
  makeChar("尼", "SP", Some(["尸", "心"]), ()),
  makeChar("尼", "SP", Some(["尸", "心"]), ()),
  // Practice mix
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尺", "SI", Some(["尸", "戈"]), ()),
  makeChar("尼", "SP", Some(["尸", "心"]), ()),
  makeChar("尸", "S", Some(["尸"]), ()),
  makeChar("尺", "SI", Some(["尸", "戈"]), ()),
]

// Lesson 20: 廿 - Learn T (廿)
let lesson20Characters = [
  // Introduce 廿
  makeChar("廿", "T", Some(["廿"]), ()),
  makeChar("廿", "T", Some(["廿"]), ()),
  makeChar("廿", "T", Some(["廿"]), ()),
  makeChar("廿", "T", Some(["廿"]), ()),
  makeChar("廿", "T", Some(["廿"]), ()),
  // Characters with 廿
  makeChar("卅", "TM", Some(["廿", "一"]), ()),
  makeChar("卅", "TM", Some(["廿", "一"]), ()),
  makeChar("草", "TA", Some(["廿", "日"]), ()),
  makeChar("草", "TA", Some(["廿", "日"]), ()),
  makeChar("若", "TR", Some(["廿", "口"]), ()),
  makeChar("若", "TR", Some(["廿", "口"]), ()),
  // Practice mix
  makeChar("廿", "T", Some(["廿"]), ()),
  makeChar("卅", "TM", Some(["廿", "一"]), ()),
  makeChar("草", "TA", Some(["廿", "日"]), ()),
  makeChar("廿", "T", Some(["廿"]), ()),
]

// Lesson 21: 山 - Learn U (山)
let lesson21Characters = [
  // Introduce 山
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  // Characters with 山
  makeChar("出", "UU", Some(["山", "山"]), ()),
  makeChar("出", "UU", Some(["山", "山"]), ()),
  // Practice mix
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("出", "UU", Some(["山", "山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("出", "UU", Some(["山", "山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
  makeChar("山", "U", Some(["山"]), ()),
]

// Lesson 22: 女 - Learn V (女)
let lesson22Characters = [
  // Introduce 女
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  // Characters with 女
  makeChar("好", "VND", Some(["女", "弓", "木"]), ()),
  makeChar("好", "VND", Some(["女", "弓", "木"]), ()),
  // Practice mix
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("好", "VND", Some(["女", "弓", "木"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("好", "VND", Some(["女", "弓", "木"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
  makeChar("女", "V", Some(["女"]), ()),
]

// Lesson 23: 田 - Learn W (田)
let lesson23Characters = [
  // Introduce 田
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  // Characters with 田
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  // Practice mix
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("東", "DW", Some(["木", "田"]), ()),
  makeChar("由", "LW", Some(["中", "田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
  makeChar("田", "W", Some(["田"]), ()),
]

// Lesson 24: 卜 - Learn Y (卜)
let lesson24Characters = [
  // Introduce 卜
  makeChar("卜", "Y", Some(["卜"]), ()),
  makeChar("卜", "Y", Some(["卜"]), ()),
  makeChar("卜", "Y", Some(["卜"]), ()),
  makeChar("卜", "Y", Some(["卜"]), ()),
  makeChar("卜", "Y", Some(["卜"]), ()),
  // Characters with 卜
  makeChar("上", "YM", Some(["卜", "一"]), ()),
  makeChar("上", "YM", Some(["卜", "一"]), ()),
  makeChar("占", "YR", Some(["卜", "口"]), ()),
  makeChar("占", "YR", Some(["卜", "口"]), ()),
  makeChar("下", "MY", Some(["一", "卜"]), ()),
  makeChar("下", "MY", Some(["一", "卜"]), ()),
  // Practice mix
  makeChar("卜", "Y", Some(["卜"]), ()),
  makeChar("上", "YM", Some(["卜", "一"]), ()),
  makeChar("占", "YR", Some(["卜", "口"]), ()),
  makeChar("下", "MY", Some(["一", "卜"]), ()),
]

// SPECIAL KEYS (特殊鍵) - Lessons 25-26
// Lesson 25: 難 - Learn X (難)
let lesson25Characters = [
  // X is used for difficult/special characters
  makeChar("卵", "XHQF", Some(["難", "竹", "手", "火"]), ()),
  makeChar("卵", "XHQF", Some(["難", "竹", "手", "火"]), ()),
  makeChar("巢", "XXHDB", Some(["難", "難", "竹", "木", "月"]), ()),
  makeChar("巢", "XXHDB", Some(["難", "難", "竹", "木", "月"]), ()),
  makeChar("鹿", "XIXP", Some(["難", "戈", "難", "心"]), ()),
  makeChar("鹿", "XIXP", Some(["難", "戈", "難", "心"]), ()),
  // Practice mix
  makeChar("卵", "XHQF", Some(["難", "竹", "手", "火"]), ()),
  makeChar("巢", "XXHDB", Some(["難", "難", "竹", "木", "月"]), ()),
  makeChar("鹿", "XIXP", Some(["難", "戈", "難", "心"]), ()),
  makeChar("卵", "XHQF", Some(["難", "竹", "手", "火"]), ()),
]

// Lesson 26: 重 - Learn Z (重)
let lesson26Characters = [
  // Z is the repeat key - used when a shape repeats
  makeChar("昌", "AA", Some(["日", "日"]), ()),
  makeChar("昌", "AA", Some(["日", "日"]), ()),
  makeChar("朋", "BB", Some(["月", "月"]), ()),
  makeChar("朋", "BB", Some(["月", "月"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("炎", "FF", Some(["火", "火"]), ()),
  makeChar("從", "OO", Some(["人", "人"]), ()),
  makeChar("從", "OO", Some(["人", "人"]), ()),
  makeChar("出", "UU", Some(["山", "山"]), ()),
  makeChar("出", "UU", Some(["山", "山"]), ()),
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

// Top 100 Most Common Characters - Advanced Lessons
// Each lesson: 5 characters, each repeated 3-4 times for practice

// SET 1: Characters 1-20 (的一是不了 + 人我在有他 + 這為之大來 + 以個中上們)
let commonChars1 = [  // 的一是不了
  makeChar("的", "HAPI", None, ~frequencyRank=1, ()),
  makeChar("的", "HAPI", None, ~frequencyRank=1, ()),
  makeChar("的", "HAPI", None, ~frequencyRank=1, ()),
  makeChar("一", "M", None, ~frequencyRank=2, ()),
  makeChar("一", "M", None, ~frequencyRank=2, ()),
  makeChar("一", "M", None, ~frequencyRank=2, ()),
  makeChar("是", "AMYO", None, ~frequencyRank=3, ()),
  makeChar("是", "AMYO", None, ~frequencyRank=3, ()),
  makeChar("是", "AMYO", None, ~frequencyRank=3, ()),
  makeChar("不", "MF", None, ~frequencyRank=4, ()),
  makeChar("不", "MF", None, ~frequencyRank=4, ()),
  makeChar("不", "MF", None, ~frequencyRank=4, ()),
  makeChar("了", "NN", None, ~frequencyRank=5, ()),
  makeChar("了", "NN", None, ~frequencyRank=5, ()),
  makeChar("了", "NN", None, ~frequencyRank=5, ()),
  // Mix practice
  makeChar("的", "HAPI", None, ~frequencyRank=1, ()),
  makeChar("一", "M", None, ~frequencyRank=2, ()),
  makeChar("是", "AMYO", None, ~frequencyRank=3, ()),
  makeChar("不", "MF", None, ~frequencyRank=4, ()),
  makeChar("了", "NN", None, ~frequencyRank=5, ()),
]

let commonChars2 = [  // 人我在有他
  makeChar("人", "O", None, ~frequencyRank=6, ()),
  makeChar("人", "O", None, ~frequencyRank=6, ()),
  makeChar("人", "O", None, ~frequencyRank=6, ()),
  makeChar("我", "HQI", None, ~frequencyRank=7, ()),
  makeChar("我", "HQI", None, ~frequencyRank=7, ()),
  makeChar("我", "HQI", None, ~frequencyRank=7, ()),
  makeChar("在", "KLG", None, ~frequencyRank=8, ()),
  makeChar("在", "KLG", None, ~frequencyRank=8, ()),
  makeChar("在", "KLG", None, ~frequencyRank=8, ()),
  makeChar("有", "KB", None, ~frequencyRank=9, ()),
  makeChar("有", "KB", None, ~frequencyRank=9, ()),
  makeChar("有", "KB", None, ~frequencyRank=9, ()),
  makeChar("他", "OPD", None, ~frequencyRank=10, ()),
  makeChar("他", "OPD", None, ~frequencyRank=10, ()),
  makeChar("他", "OPD", None, ~frequencyRank=10, ()),
  // Mix practice
  makeChar("人", "O", None, ~frequencyRank=6, ()),
  makeChar("我", "HQI", None, ~frequencyRank=7, ()),
  makeChar("在", "KLG", None, ~frequencyRank=8, ()),
  makeChar("有", "KB", None, ~frequencyRank=9, ()),
  makeChar("他", "OPD", None, ~frequencyRank=10, ()),
]

let commonChars3 = [  // 這為之大來
  makeChar("這", "YYK", None, ~frequencyRank=11, ()),
  makeChar("這", "YYK", None, ~frequencyRank=11, ()),
  makeChar("這", "YYK", None, ~frequencyRank=11, ()),
  makeChar("為", "IKSI", None, ~frequencyRank=12, ()),
  makeChar("為", "IKSI", None, ~frequencyRank=12, ()),
  makeChar("為", "IKSI", None, ~frequencyRank=12, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("來", "DT", None, ~frequencyRank=15, ()),
  makeChar("來", "DT", None, ~frequencyRank=15, ()),
  makeChar("來", "DT", None, ~frequencyRank=15, ()),
  // Mix practice
  makeChar("這", "YYK", None, ~frequencyRank=11, ()),
  makeChar("為", "IKSI", None, ~frequencyRank=12, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("來", "DT", None, ~frequencyRank=15, ()),
]

let commonChars4 = [  // 以個中上們
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("個", "OL", None, ~frequencyRank=17, ()),
  makeChar("個", "OL", None, ~frequencyRank=17, ()),
  makeChar("個", "OL", None, ~frequencyRank=17, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("們", "OLIS", None, ~frequencyRank=20, ()),
  makeChar("們", "OLIS", None, ~frequencyRank=20, ()),
  makeChar("們", "OLIS", None, ~frequencyRank=20, ()),
  // Mix practice
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("個", "OL", None, ~frequencyRank=17, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("們", "OLIS", None, ~frequencyRank=20, ()),
]

// SET 2: Characters 21-40
let commonChars5 = [  // 到說國和地
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("說", "IVCRU", None, ~frequencyRank=22, ()),
  makeChar("說", "IVCRU", None, ~frequencyRank=22, ()),
  makeChar("說", "IVCRU", None, ~frequencyRank=22, ()),
  makeChar("國", "WMGI", None, ~frequencyRank=23, ()),
  makeChar("國", "WMGI", None, ~frequencyRank=23, ()),
  makeChar("國", "WMGI", None, ~frequencyRank=23, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  // Mix practice
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("說", "IVCRU", None, ~frequencyRank=22, ()),
  makeChar("國", "WMGI", None, ~frequencyRank=23, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
]

let commonChars6 = [  // 也子時道出
  makeChar("也", "PD", None, ~frequencyRank=26, ()),
  makeChar("也", "PD", None, ~frequencyRank=26, ()),
  makeChar("也", "PD", None, ~frequencyRank=26, ()),
  makeChar("子", "ND", None, ~frequencyRank=27, ()),
  makeChar("子", "ND", None, ~frequencyRank=27, ()),
  makeChar("子", "ND", None, ~frequencyRank=27, ()),
  makeChar("時", "ADI", None, ~frequencyRank=28, ()),
  makeChar("時", "ADI", None, ~frequencyRank=28, ()),
  makeChar("時", "ADI", None, ~frequencyRank=28, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  // Mix practice
  makeChar("也", "PD", None, ~frequencyRank=26, ()),
  makeChar("子", "ND", None, ~frequencyRank=27, ()),
  makeChar("時", "ADI", None, ~frequencyRank=28, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
]

let commonChars7 = [  // 而要於就下
  makeChar("而", "MBLL", None, ~frequencyRank=31, ()),
  makeChar("而", "MBLL", None, ~frequencyRank=31, ()),
  makeChar("而", "MBLL", None, ~frequencyRank=31, ()),
  makeChar("要", "MWV", None, ~frequencyRank=32, ()),
  makeChar("要", "MWV", None, ~frequencyRank=32, ()),
  makeChar("要", "MWV", None, ~frequencyRank=32, ()),
  makeChar("於", "MD", None, ~frequencyRank=33, ()),
  makeChar("於", "MD", None, ~frequencyRank=33, ()),
  makeChar("於", "MD", None, ~frequencyRank=33, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  // Mix practice
  makeChar("而", "MBLL", None, ~frequencyRank=31, ()),
  makeChar("要", "MWV", None, ~frequencyRank=32, ()),
  makeChar("於", "MD", None, ~frequencyRank=33, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
]

let commonChars8 = [  // 得可你年生
  makeChar("得", "HOAMI", None, ~frequencyRank=36, ()),
  makeChar("得", "HOAMI", None, ~frequencyRank=36, ()),
  makeChar("得", "HOAMI", None, ~frequencyRank=36, ()),
  makeChar("可", "MNR", None, ~frequencyRank=37, ()),
  makeChar("可", "MNR", None, ~frequencyRank=37, ()),
  makeChar("可", "MNR", None, ~frequencyRank=37, ()),
  makeChar("你", "ONF", None, ~frequencyRank=38, ()),
  makeChar("你", "ONF", None, ~frequencyRank=38, ()),
  makeChar("你", "ONF", None, ~frequencyRank=38, ()),
  makeChar("年", "OQ", None, ~frequencyRank=39, ()),
  makeChar("年", "OQ", None, ~frequencyRank=39, ()),
  makeChar("年", "OQ", None, ~frequencyRank=39, ()),
  makeChar("生", "HQM", None, ~frequencyRank=40, ()),
  makeChar("生", "HQM", None, ~frequencyRank=40, ()),
  makeChar("生", "HQM", None, ~frequencyRank=40, ()),
  // Mix practice
  makeChar("得", "HOAMI", None, ~frequencyRank=36, ()),
  makeChar("可", "MNR", None, ~frequencyRank=37, ()),
  makeChar("你", "ONF", None, ~frequencyRank=38, ()),
  makeChar("年", "OQ", None, ~frequencyRank=39, ()),
  makeChar("生", "HQM", None, ~frequencyRank=40, ()),
]

// SET 3: Characters 41-60
let commonChars9 = [  // 自會那後能
  makeChar("自", "HBU", None, ~frequencyRank=41, ()),
  makeChar("自", "HBU", None, ~frequencyRank=41, ()),
  makeChar("自", "HBU", None, ~frequencyRank=41, ()),
  makeChar("會", "OMMI", None, ~frequencyRank=42, ()),
  makeChar("會", "OMMI", None, ~frequencyRank=42, ()),
  makeChar("會", "OMMI", None, ~frequencyRank=42, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("後", "HMR", None, ~frequencyRank=44, ()),
  makeChar("後", "HMR", None, ~frequencyRank=44, ()),
  makeChar("後", "HMR", None, ~frequencyRank=44, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  // Mix practice
  makeChar("自", "HBU", None, ~frequencyRank=41, ()),
  makeChar("會", "OMMI", None, ~frequencyRank=42, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("後", "HMR", None, ~frequencyRank=44, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
]

let commonChars10 = [  // 對著事其里
  makeChar("對", "EDI", None, ~frequencyRank=46, ()),
  makeChar("對", "EDI", None, ~frequencyRank=46, ()),
  makeChar("對", "EDI", None, ~frequencyRank=46, ()),
  makeChar("著", "TQBU", None, ~frequencyRank=47, ()),
  makeChar("著", "TQBU", None, ~frequencyRank=47, ()),
  makeChar("著", "TQBU", None, ~frequencyRank=47, ()),
  makeChar("事", "JLLN", None, ~frequencyRank=48, ()),
  makeChar("事", "JLLN", None, ~frequencyRank=48, ()),
  makeChar("事", "JLLN", None, ~frequencyRank=48, ()),
  makeChar("其", "TMMC", None, ~frequencyRank=49, ()),
  makeChar("其", "TMMC", None, ~frequencyRank=49, ()),
  makeChar("其", "TMMC", None, ~frequencyRank=49, ()),
  makeChar("里", "WG", None, ~frequencyRank=50, ()),
  makeChar("里", "WG", None, ~frequencyRank=50, ()),
  makeChar("里", "WG", None, ~frequencyRank=50, ()),
  // Mix practice
  makeChar("對", "EDI", None, ~frequencyRank=46, ()),
  makeChar("著", "TQBU", None, ~frequencyRank=47, ()),
  makeChar("事", "JLLN", None, ~frequencyRank=48, ()),
  makeChar("其", "TMMC", None, ~frequencyRank=49, ()),
  makeChar("里", "WG", None, ~frequencyRank=50, ()),
]

let commonChars11 = [  // 所去行過家
  makeChar("所", "HSHML", None, ~frequencyRank=51, ()),
  makeChar("所", "HSHML", None, ~frequencyRank=51, ()),
  makeChar("所", "HSHML", None, ~frequencyRank=51, ()),
  makeChar("去", "GI", None, ~frequencyRank=52, ()),
  makeChar("去", "GI", None, ~frequencyRank=52, ()),
  makeChar("去", "GI", None, ~frequencyRank=52, ()),
  makeChar("行", "HOMMN", None, ~frequencyRank=53, ()),
  makeChar("行", "HOMMN", None, ~frequencyRank=53, ()),
  makeChar("行", "HOMMN", None, ~frequencyRank=53, ()),
  makeChar("過", "YDI", None, ~frequencyRank=54, ()),
  makeChar("過", "YDI", None, ~frequencyRank=54, ()),
  makeChar("過", "YDI", None, ~frequencyRank=54, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  // Mix practice
  makeChar("所", "HSHML", None, ~frequencyRank=51, ()),
  makeChar("去", "GI", None, ~frequencyRank=52, ()),
  makeChar("行", "HOMMN", None, ~frequencyRank=53, ()),
  makeChar("過", "YDI", None, ~frequencyRank=54, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
]

let commonChars12 = [  // 十用發天如
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("發", "IVKE", None, ~frequencyRank=58, ()),
  makeChar("發", "IVKE", None, ~frequencyRank=58, ()),
  makeChar("發", "IVKE", None, ~frequencyRank=58, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  // Mix practice
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("發", "IVKE", None, ~frequencyRank=58, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
]

// SET 4: Characters 61-75
let commonChars13 = [  // 然作方成者
  makeChar("然", "BKF", None, ~frequencyRank=61, ()),
  makeChar("然", "BKF", None, ~frequencyRank=61, ()),
  makeChar("然", "BKF", None, ~frequencyRank=61, ()),
  makeChar("作", "OOS", None, ~frequencyRank=62, ()),
  makeChar("作", "OOS", None, ~frequencyRank=62, ()),
  makeChar("作", "OOS", None, ~frequencyRank=62, ()),
  makeChar("方", "YHS", None, ~frequencyRank=63, ()),
  makeChar("方", "YHS", None, ~frequencyRank=63, ()),
  makeChar("方", "YHS", None, ~frequencyRank=63, ()),
  makeChar("成", "IHS", None, ~frequencyRank=64, ()),
  makeChar("成", "IHS", None, ~frequencyRank=64, ()),
  makeChar("成", "IHS", None, ~frequencyRank=64, ()),
  makeChar("者", "JKA", None, ~frequencyRank=65, ()),
  makeChar("者", "JKA", None, ~frequencyRank=65, ()),
  makeChar("者", "JKA", None, ~frequencyRank=65, ()),
  // Mix practice
  makeChar("然", "BKF", None, ~frequencyRank=61, ()),
  makeChar("作", "OOS", None, ~frequencyRank=62, ()),
  makeChar("方", "YHS", None, ~frequencyRank=63, ()),
  makeChar("成", "IHS", None, ~frequencyRank=64, ()),
  makeChar("者", "JKA", None, ~frequencyRank=65, ()),
]

let commonChars14 = [  // 多日都三同
  makeChar("多", "NINI", None, ~frequencyRank=66, ()),
  makeChar("多", "NINI", None, ~frequencyRank=66, ()),
  makeChar("多", "NINI", None, ~frequencyRank=66, ()),
  makeChar("日", "A", None, ~frequencyRank=67, ()),
  makeChar("日", "A", None, ~frequencyRank=67, ()),
  makeChar("日", "A", None, ~frequencyRank=67, ()),
  makeChar("都", "JANL", None, ~frequencyRank=68, ()),
  makeChar("都", "JANL", None, ~frequencyRank=68, ()),
  makeChar("都", "JANL", None, ~frequencyRank=68, ()),
  makeChar("三", "MMM", None, ~frequencyRank=69, ()),
  makeChar("三", "MMM", None, ~frequencyRank=69, ()),
  makeChar("三", "MMM", None, ~frequencyRank=69, ()),
  makeChar("同", "BMR", None, ~frequencyRank=70, ()),
  makeChar("同", "BMR", None, ~frequencyRank=70, ()),
  makeChar("同", "BMR", None, ~frequencyRank=70, ()),
  // Mix practice
  makeChar("多", "NINI", None, ~frequencyRank=66, ()),
  makeChar("日", "A", None, ~frequencyRank=67, ()),
  makeChar("都", "JANL", None, ~frequencyRank=68, ()),
  makeChar("三", "MMM", None, ~frequencyRank=69, ()),
  makeChar("同", "BMR", None, ~frequencyRank=70, ()),
]

let commonChars15 = [  // 已經法當起
  makeChar("已", "SU", None, ~frequencyRank=71, ()),
  makeChar("已", "SU", None, ~frequencyRank=71, ()),
  makeChar("已", "SU", None, ~frequencyRank=71, ()),
  makeChar("經", "VMNOM", None, ~frequencyRank=72, ()),
  makeChar("經", "VMNOM", None, ~frequencyRank=72, ()),
  makeChar("經", "VMNOM", None, ~frequencyRank=72, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("當", "FSM", None, ~frequencyRank=74, ()),
  makeChar("當", "FSM", None, ~frequencyRank=74, ()),
  makeChar("當", "FSM", None, ~frequencyRank=74, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  // Mix practice
  makeChar("已", "SU", None, ~frequencyRank=71, ()),
  makeChar("經", "VMNOM", None, ~frequencyRank=72, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("當", "FSM", None, ~frequencyRank=74, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
]

// SET 5: Characters 76-90
let commonChars16 = [  // 與好看學進
  makeChar("與", "YSM", None, ~frequencyRank=76, ()),
  makeChar("與", "YSM", None, ~frequencyRank=76, ()),
  makeChar("與", "YSM", None, ~frequencyRank=76, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("學", "FBND", None, ~frequencyRank=79, ()),
  makeChar("學", "FBND", None, ~frequencyRank=79, ()),
  makeChar("學", "FBND", None, ~frequencyRank=79, ()),
  makeChar("進", "YTT", None, ~frequencyRank=80, ()),
  makeChar("進", "YTT", None, ~frequencyRank=80, ()),
  makeChar("進", "YTT", None, ~frequencyRank=80, ()),
  // Mix practice
  makeChar("與", "YSM", None, ~frequencyRank=76, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("學", "FBND", None, ~frequencyRank=79, ()),
  makeChar("進", "YTT", None, ~frequencyRank=80, ()),
]

let commonChars17 = [  // 種將還分此
  makeChar("種", "HDL", None, ~frequencyRank=81, ()),
  makeChar("種", "HDL", None, ~frequencyRank=81, ()),
  makeChar("種", "HDL", None, ~frequencyRank=81, ()),
  makeChar("將", "LMNII", None, ~frequencyRank=82, ()),
  makeChar("將", "LMNII", None, ~frequencyRank=82, ()),
  makeChar("將", "LMNII", None, ~frequencyRank=82, ()),
  makeChar("還", "YMF", None, ~frequencyRank=83, ()),
  makeChar("還", "YMF", None, ~frequencyRank=83, ()),
  makeChar("還", "YMF", None, ~frequencyRank=83, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  // Mix practice
  makeChar("種", "HDL", None, ~frequencyRank=81, ()),
  makeChar("將", "LMNII", None, ~frequencyRank=82, ()),
  makeChar("還", "YMF", None, ~frequencyRank=83, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
]

let commonChars18 = [  // 心前面又定
  makeChar("心", "P", None, ~frequencyRank=86, ()),
  makeChar("心", "P", None, ~frequencyRank=86, ()),
  makeChar("心", "P", None, ~frequencyRank=86, ()),
  makeChar("前", "TBLN", None, ~frequencyRank=87, ()),
  makeChar("前", "TBLN", None, ~frequencyRank=87, ()),
  makeChar("前", "TBLN", None, ~frequencyRank=87, ()),
  makeChar("面", "MWSL", None, ~frequencyRank=88, ()),
  makeChar("面", "MWSL", None, ~frequencyRank=88, ()),
  makeChar("面", "MWSL", None, ~frequencyRank=88, ()),
  makeChar("又", "NK", None, ~frequencyRank=89, ()),
  makeChar("又", "NK", None, ~frequencyRank=89, ()),
  makeChar("又", "NK", None, ~frequencyRank=89, ()),
  makeChar("定", "JMYO", None, ~frequencyRank=90, ()),
  makeChar("定", "JMYO", None, ~frequencyRank=90, ()),
  makeChar("定", "JMYO", None, ~frequencyRank=90, ()),
  // Mix practice
  makeChar("心", "P", None, ~frequencyRank=86, ()),
  makeChar("前", "TBLN", None, ~frequencyRank=87, ()),
  makeChar("面", "MWSL", None, ~frequencyRank=88, ()),
  makeChar("又", "NK", None, ~frequencyRank=89, ()),
  makeChar("定", "JMYO", None, ~frequencyRank=90, ()),
]

// SET 6: Characters 91-96 (final set)
let commonChars19 = [  // 見只主沒公從
  makeChar("見", "BHU", None, ~frequencyRank=91, ()),
  makeChar("見", "BHU", None, ~frequencyRank=91, ()),
  makeChar("見", "BHU", None, ~frequencyRank=91, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("沒", "EHNE", None, ~frequencyRank=94, ()),
  makeChar("沒", "EHNE", None, ~frequencyRank=94, ()),
  makeChar("沒", "EHNE", None, ~frequencyRank=94, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("從", "OO", None, ~frequencyRank=96, ()),
  makeChar("從", "OO", None, ~frequencyRank=96, ()),
  makeChar("從", "OO", None, ~frequencyRank=96, ()),
  // Mix practice - all 6 characters
  makeChar("見", "BHU", None, ~frequencyRank=91, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("沒", "EHNE", None, ~frequencyRank=94, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("從", "OO", None, ~frequencyRank=96, ()),
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
    // SECTION 1: PHILOSOPHY (哲理類) - Lessons 1-6
    // Lesson 1: 日月
    makeLesson(1, "哲理 1：日月", "學習 A(日) 和 B(月)",
      Philosophy, Radicals, Practice, [A, B],
      Js.Array2.concat(lesson1Characters, lesson2Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 2: 金木
    makeLesson(2, "哲理 2：金木", "學習 C(金) 和 D(木)",
      Philosophy, Radicals, Practice, [C, D],
      Js.Array2.concat(lesson3Characters, lesson4Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 3: 水火
    makeLesson(3, "哲理 3：水火", "學習 E(水) 和 F(火)",
      Philosophy, Radicals, Practice, [E, F],
      Js.Array2.concat(lesson5Characters, lesson6Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 4: 土
    makeLesson(4, "哲理 4：土", "學習 G(土)",
      Philosophy, Radicals, Practice, [G], lesson7Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 5: Review
    makeLesson(5, "哲理複習", "複習哲理類所有部首",
      Philosophy, Radicals, Review, [A, B, C, D, E, F, G],
      Js.Array2.concat(
        Js.Array2.concat(lesson1Characters, lesson2Characters),
        Js.Array2.concat(
          Js.Array2.concat(lesson3Characters, lesson4Characters),
          Js.Array2.concat(
            Js.Array2.concat(lesson5Characters, lesson6Characters),
            lesson7Characters
          )
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 4], ()),

    // Lesson 6: Comprehensive Review
    makeLesson(6, "哲理綜合", "綜合練習哲理類應用",
      Philosophy, Radicals, MixedReview, [A, B, C, D, E, F, G],
      Js.Array2.concat(
        Js.Array2.concat(
          Js.Array2.concat(lesson1Characters, lesson2Characters),
          Js.Array2.concat(
            Js.Array2.concat(lesson3Characters, lesson4Characters),
            Js.Array2.concat(
              Js.Array2.concat(lesson5Characters, lesson6Characters),
              lesson7Characters
            )
          )
        ),
        application3Characters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 4], ()),

    // SECTION 2: STROKES (筆畫類) - Lessons 7-12
    // Lesson 7: 竹戈
    makeLesson(7, "筆畫 1：竹戈", "學習 H(竹) 和 I(戈)",
      Strokes, Radicals, Practice, [H, I],
      Js.Array2.concat(lesson8Characters, lesson9Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 8: 十大
    makeLesson(8, "筆畫 2：十大", "學習 J(十) 和 K(大)",
      Strokes, Radicals, Practice, [J, K],
      Js.Array2.concat(lesson10Characters, lesson11Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 9: 中一
    makeLesson(9, "筆畫 3：中一", "學習 L(中) 和 M(一)",
      Strokes, Radicals, Practice, [L, M],
      Js.Array2.concat(lesson12Characters, lesson13Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 10: 弓
    makeLesson(10, "筆畫 4：弓", "學習 N(弓)",
      Strokes, Radicals, Practice, [N], lesson14Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 11: Review
    makeLesson(11, "筆畫複習", "複習筆畫類所有部首",
      Strokes, Radicals, Review, [H, I, J, K, L, M, N],
      Js.Array2.concat(
        Js.Array2.concat(lesson8Characters, lesson9Characters),
        Js.Array2.concat(
          Js.Array2.concat(lesson10Characters, lesson11Characters),
          Js.Array2.concat(
            Js.Array2.concat(lesson12Characters, lesson13Characters),
            lesson14Characters
          )
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[7, 8, 9, 10], ()),

    // Lesson 12: Comprehensive Review
    makeLesson(12, "筆畫綜合", "綜合練習筆畫類應用",
      Strokes, Radicals, MixedReview, [H, I, J, K, L, M, N],
      Js.Array2.concat(
        Js.Array2.concat(
          Js.Array2.concat(lesson8Characters, lesson9Characters),
          Js.Array2.concat(
            Js.Array2.concat(lesson10Characters, lesson11Characters),
            Js.Array2.concat(
              Js.Array2.concat(lesson12Characters, lesson13Characters),
              lesson14Characters
            )
          )
        ),
        application1Characters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[7, 8, 9, 10], ()),

    // SECTION 3: BODY PARTS (人體類) - Lessons 13-16
    // Lesson 13: 人心
    makeLesson(13, "人體 1：人心", "學習 O(人) 和 P(心)",
      BodyParts, Radicals, Practice, [O, P],
      Js.Array2.concat(lesson15Characters, lesson16Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 14: 手口
    makeLesson(14, "人體 2：手口", "學習 Q(手) 和 R(口)",
      BodyParts, Radicals, Practice, [Q, R],
      Js.Array2.concat(lesson17Characters, lesson18Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 15: Review
    makeLesson(15, "人體複習", "複習人體類所有部首",
      BodyParts, Radicals, Review, [O, P, Q, R],
      Js.Array2.concat(
        Js.Array2.concat(lesson15Characters, lesson16Characters),
        Js.Array2.concat(lesson17Characters, lesson18Characters)
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[13, 14], ()),

    // Lesson 16: Comprehensive Review
    makeLesson(16, "人體綜合", "綜合練習人體類應用",
      BodyParts, Radicals, MixedReview, [O, P, Q, R],
      Js.Array2.concat(
        Js.Array2.concat(
          Js.Array2.concat(lesson15Characters, lesson16Characters),
          Js.Array2.concat(lesson17Characters, lesson18Characters)
        ),
        application2Characters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[13, 14], ()),

    // SECTION 4: CHARACTER SHAPES (字形類) - Lessons 17-21
    // Lesson 17: 尸廿
    makeLesson(17, "字形 1：尸廿", "學習 S(尸) 和 T(廿)",
      CharacterShapes, Radicals, Practice, [S, T],
      Js.Array2.concat(lesson19Characters, lesson20Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 18: 山女
    makeLesson(18, "字形 2：山女", "學習 U(山) 和 V(女)",
      CharacterShapes, Radicals, Practice, [U, V],
      Js.Array2.concat(lesson21Characters, lesson22Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 19: 田卜
    makeLesson(19, "字形 3：田卜", "學習 W(田) 和 Y(卜)",
      CharacterShapes, Radicals, Practice, [W, Y],
      Js.Array2.concat(lesson23Characters, lesson24Characters), ~showCode=false, ~allowHints=true, ()),

    // Lesson 20: Review
    makeLesson(20, "字形複習", "複習字形類所有部首",
      CharacterShapes, Radicals, Review, [S, T, U, V, W, Y],
      Js.Array2.concat(
        Js.Array2.concat(lesson19Characters, lesson20Characters),
        Js.Array2.concat(
          Js.Array2.concat(lesson21Characters, lesson22Characters),
          Js.Array2.concat(lesson23Characters, lesson24Characters)
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[17, 18, 19], ()),

    // Lesson 21: Comprehensive Review
    makeLesson(21, "字形綜合", "綜合練習字形類應用",
      CharacterShapes, Radicals, MixedReview, [S, T, U, V, W, Y],
      Js.Array2.concat(
        Js.Array2.concat(
          Js.Array2.concat(lesson19Characters, lesson20Characters),
          Js.Array2.concat(
            Js.Array2.concat(lesson21Characters, lesson22Characters),
            Js.Array2.concat(lesson23Characters, lesson24Characters)
          )
        ),
        application2Characters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[17, 18, 19], ()),

    // SECTION 5: SPECIAL KEYS (特殊鍵) - Lessons 22-25
    // Lesson 22: 難
    makeLesson(22, "特殊鍵 1：難", "學習 X(難)",
      Advanced, Radicals, Practice, [X], lesson25Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 23: 重
    makeLesson(23, "特殊鍵 2：重", "學習重複鍵的使用",
      Advanced, Radicals, Practice, [Z], lesson26Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 24: Review
    makeLesson(24, "特殊鍵複習", "複習特殊鍵",
      Advanced, Radicals, Review, [X, Z],
      Js.Array2.concat(lesson25Characters, lesson26Characters),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[22, 23], ()),

    // Lesson 25: Comprehensive Review - All radicals
    makeLesson(25, "特殊鍵綜合", "綜合複習所有基礎部首",
      Advanced, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, Y, X, Z],
      Js.Array2.concat(lesson25Characters, lesson26Characters),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], ()),
  ]

  // SECTION 6: TOP COMMON (前100個字) - Lessons 26-onwards
  // Pattern: 3-4 content lessons → review → comprehensive review

  let commonCharLessons = [
    // SET 1: Lessons 26-31 (Characters 1-20)
    makeLesson(26, "常用字（一）：的一是不了", "學習最常用的五個字",
      TopCommon, CommonWords, Practice, [], commonChars1, ~showCode=false, ~allowHints=true, ()),
    makeLesson(27, "常用字（二）：人我在有他", "學習常用代詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars2, ~showCode=false, ~allowHints=true, ()),
    makeLesson(28, "常用字（三）：這為之大來", "學習常用連詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars3, ~showCode=false, ~allowHints=true, ()),
    makeLesson(29, "常用字（四）：以個中上們", "學習常用介詞和量詞",
      TopCommon, CommonWords, Practice, [], commonChars4, ~showCode=false, ~allowHints=true, ()),
    makeLesson(30, "複習：字符 1-20", "複習第二十六到二十九課的常用字",
      TopCommon, CommonWords, Review, [],
      Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4))),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29], ()),
    makeLesson(31, "綜合複習：字符 1-20", "隨機複習所有已學常用字",
      TopCommon, CommonWords, MixedReview, [],
      CangjieUtils.shuffleArray(Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4)))),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29], ()),

    // SET 2: Lessons 32-37 (Characters 21-40)
    makeLesson(32, "常用字（五）：到說國和地", "學習常用動詞和名詞",
      TopCommon, CommonWords, Practice, [], commonChars5, ~showCode=false, ~allowHints=true, ()),
    makeLesson(33, "常用字（六）：也子時道出", "學習常用副詞和時間詞",
      TopCommon, CommonWords, Practice, [], commonChars6, ~showCode=false, ~allowHints=true, ()),
    makeLesson(34, "常用字（七）：而要於就下", "學習常用連詞和方位詞",
      TopCommon, CommonWords, Practice, [], commonChars7, ~showCode=false, ~allowHints=true, ()),
    makeLesson(35, "常用字（八）：得可你年生", "學習常用動詞和名詞",
      TopCommon, CommonWords, Practice, [], commonChars8, ~showCode=false, ~allowHints=true, ()),
    makeLesson(36, "複習：字符 21-40", "複習第三十二到三十五課的常用字",
      TopCommon, CommonWords, Review, [],
      Js.Array2.concat(commonChars5, Js.Array2.concat(commonChars6, Js.Array2.concat(commonChars7, commonChars8))),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[32, 33, 34, 35], ()),
    makeLesson(37, "綜合複習：字符 1-40", "隨機複習所有已學常用字",
      TopCommon, CommonWords, MixedReview, [],
      CangjieUtils.shuffleArray(
        Js.Array2.concat(
          Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4))),
          Js.Array2.concat(commonChars5, Js.Array2.concat(commonChars6, Js.Array2.concat(commonChars7, commonChars8)))
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29, 32, 33, 34, 35], ()),

    // SET 3: Lessons 38-43 (Characters 41-60)
    makeLesson(38, "常用字（九）：自會那後能", "學習常用代詞和助動詞",
      TopCommon, CommonWords, Practice, [], commonChars9, ~showCode=false, ~allowHints=true, ()),
    makeLesson(39, "常用字（十）：對著事其里", "學習常用動詞和名詞",
      TopCommon, CommonWords, Practice, [], commonChars10, ~showCode=false, ~allowHints=true, ()),
    makeLesson(40, "常用字（十一）：所去行過家", "學習常用動詞和名詞",
      TopCommon, CommonWords, Practice, [], commonChars11, ~showCode=false, ~allowHints=true, ()),
    makeLesson(41, "常用字（十二）：十用發天如", "學習常用數詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars12, ~showCode=false, ~allowHints=true, ()),
    makeLesson(42, "複習：字符 41-60", "複習第三十八到四十一課的常用字",
      TopCommon, CommonWords, Review, [],
      Js.Array2.concat(commonChars9, Js.Array2.concat(commonChars10, Js.Array2.concat(commonChars11, commonChars12))),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[38, 39, 40, 41], ()),
    makeLesson(43, "綜合複習：字符 1-60", "隨機複習所有已學常用字",
      TopCommon, CommonWords, MixedReview, [],
      CangjieUtils.shuffleArray(
        Js.Array2.concat(
          Js.Array2.concat(
            Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4))),
            Js.Array2.concat(commonChars5, Js.Array2.concat(commonChars6, Js.Array2.concat(commonChars7, commonChars8)))
          ),
          Js.Array2.concat(commonChars9, Js.Array2.concat(commonChars10, Js.Array2.concat(commonChars11, commonChars12)))
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29, 32, 33, 34, 35, 38, 39, 40, 41], ()),

    // SET 4: Lessons 44-48 (Characters 61-75)
    makeLesson(44, "常用字（十三）：然作方成者", "學習常用副詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars13, ~showCode=false, ~allowHints=true, ()),
    makeLesson(45, "常用字（十四）：多日都三同", "學習常用量詞和形容詞",
      TopCommon, CommonWords, Practice, [], commonChars14, ~showCode=false, ~allowHints=true, ()),
    makeLesson(46, "常用字（十五）：已經法當起", "學習常用副詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars15, ~showCode=false, ~allowHints=true, ()),
    makeLesson(47, "複習：字符 61-75", "複習第四十四到四十六課的常用字",
      TopCommon, CommonWords, Review, [],
      Js.Array2.concat(commonChars13, Js.Array2.concat(commonChars14, commonChars15)),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[44, 45, 46], ()),
    makeLesson(48, "綜合複習：字符 1-75", "隨機複習所有已學常用字",
      TopCommon, CommonWords, MixedReview, [],
      CangjieUtils.shuffleArray(
        Js.Array2.concat(
          Js.Array2.concat(
            Js.Array2.concat(
              Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4))),
              Js.Array2.concat(commonChars5, Js.Array2.concat(commonChars6, Js.Array2.concat(commonChars7, commonChars8)))
            ),
            Js.Array2.concat(commonChars9, Js.Array2.concat(commonChars10, Js.Array2.concat(commonChars11, commonChars12)))
          ),
          Js.Array2.concat(commonChars13, Js.Array2.concat(commonChars14, commonChars15))
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29, 32, 33, 34, 35, 38, 39, 40, 41, 44, 45, 46], ()),

    // SET 5: Lessons 49-54 (Characters 76-96)
    makeLesson(49, "常用字（十六）：與好看學進", "學習常用連詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars16, ~showCode=false, ~allowHints=true, ()),
    makeLesson(50, "常用字（十七）：種將還分此", "學習常用名詞和動詞",
      TopCommon, CommonWords, Practice, [], commonChars17, ~showCode=false, ~allowHints=true, ()),
    makeLesson(51, "常用字（十八）：心前面又定", "學習常用名詞和副詞",
      TopCommon, CommonWords, Practice, [], commonChars18, ~showCode=false, ~allowHints=true, ()),
    makeLesson(52, "常用字（十九）：見只主沒公從", "學習常用動詞和副詞",
      TopCommon, CommonWords, Practice, [], commonChars19, ~showCode=false, ~allowHints=true, ()),
    makeLesson(53, "複習：字符 76-96", "複習第四十九到五十二課的常用字",
      TopCommon, CommonWords, Review, [],
      Js.Array2.concat(commonChars16, Js.Array2.concat(commonChars17, Js.Array2.concat(commonChars18, commonChars19))),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[49, 50, 51, 52], ()),
    makeLesson(54, "綜合複習：前100常用字", "隨機複習所有已學的96個常用字",
      TopCommon, CommonWords, MixedReview, [],
      CangjieUtils.shuffleArray(
        Js.Array2.concat(
          Js.Array2.concat(
            Js.Array2.concat(
              Js.Array2.concat(
                Js.Array2.concat(
                  Js.Array2.concat(commonChars1, Js.Array2.concat(commonChars2, Js.Array2.concat(commonChars3, commonChars4))),
                  Js.Array2.concat(commonChars5, Js.Array2.concat(commonChars6, Js.Array2.concat(commonChars7, commonChars8)))
                ),
                Js.Array2.concat(commonChars9, Js.Array2.concat(commonChars10, Js.Array2.concat(commonChars11, commonChars12)))
              ),
              Js.Array2.concat(commonChars13, Js.Array2.concat(commonChars14, commonChars15))
            ),
            Js.Array2.concat(commonChars16, Js.Array2.concat(commonChars17, commonChars18))
          ),
          commonChars19
        )
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29, 32, 33, 34, 35, 38, 39, 40, 41, 44, 45, 46, 49, 50, 51, 52], ()),
  ]

  // Placement test
  let placementTest = [
    makeLesson(100, "程度測驗", "測試您的倉頡輸入水平",
      Advanced, Radicals, PlacementTest, [], placementTestChars, ()),
  ]

  // Combine all lessons
  Js.Array2.concat(
    basicRadicalLessons,
    Js.Array2.concat(commonCharLessons, placementTest)
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
      section: Advanced,
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
      section: Advanced,
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

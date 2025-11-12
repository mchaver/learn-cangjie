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

// Character Dictionary - each character defined once
// This is the single source of truth for all characters and their Cangjie codes
let characterDictionary: Belt.Map.String.t<characterInfo> = Belt.Map.String.fromArray([

  // 1-key characters
  ("日", makeChar("日", "A", Some(["日"]), ())),
  ("月", makeChar("月", "B", Some(["月"]), ())),
  ("金", makeChar("金", "C", Some(["金"]), ())),
  ("木", makeChar("木", "D", Some(["木"]), ())),
  ("水", makeChar("水", "E", Some(["水"]), ())),
  ("火", makeChar("火", "F", Some(["火"]), ())),
  ("土", makeChar("土", "G", Some(["土"]), ())),
  ("竹", makeChar("竹", "H", Some(["竹"]), ())),
  ("戈", makeChar("戈", "I", Some(["戈"]), ())),
  ("十", makeChar("十", "J", Some(["十"]), ())),
  ("大", makeChar("大", "K", Some(["大"]), ())),
  ("中", makeChar("中", "L", Some(["中"]), ())),
  ("一", makeChar("一", "M", Some(["一"]), ())),
  ("弓", makeChar("弓", "N", Some(["弓"]), ())),
  ("人", makeChar("人", "O", Some(["人"]), ())),
  ("心", makeChar("心", "P", Some(["心"]), ())),
  ("手", makeChar("手", "Q", Some(["手"]), ())),
  ("口", makeChar("口", "R", Some(["口"]), ())),
  ("尸", makeChar("尸", "S", Some(["尸"]), ())),
  ("廿", makeChar("廿", "T", Some(["廿"]), ())),
  ("山", makeChar("山", "U", Some(["山"]), ())),
  ("女", makeChar("女", "V", Some(["女"]), ())),
  ("田", makeChar("田", "W", Some(["田"]), ())),
  ("卜", makeChar("卜", "Y", Some(["卜"]), ())),

  // 2-key characters
  ("昌", makeChar("昌", "AA", Some(["日", "日"]), ())),
  ("㸓", makeChar("㸓", "BA", Some(["月", "日"]), ())),
  ("明", makeChar("明", "AB", Some(["日", "月"]), ())),
  ("杲", makeChar("杲", "AD", Some(["日", "木"]), ())),
  ("早", makeChar("早", "AJ", Some(["日", "十"]), ())),
  ("旦", makeChar("旦", "AM", Some(["日", "一"]), ())),
  ("朋", makeChar("朋", "BB", Some(["月", "月"]), ())),
  ("采", makeChar("采", "BD", Some(["月", "木"]), ())),
  ("㓁", makeChar("㓁", "BC", Some(["月", "金"]), ())),
  ("肚", makeChar("肚", "BG", Some(["月", "土"]), ())),
  ("鈤", makeChar("鈤", "CA", Some(["金", "日"]), ())),
  ("鈅", makeChar("鈅", "CB", Some(["金", "月"]), ())),
  ("釟", makeChar("釟", "CC", Some(["金", "金"]), ())),
  ("公", makeChar("公", "CI", Some(["金", "戈"]), ())),
  ("杳", makeChar("杳", "DA", Some(["木", "日"]), ())),
  ("朿", makeChar("朿", "DB", Some(["木", "月"]), ())),
  ("朳", makeChar("朳", "DC", Some(["木", "金"]), ())),
  ("林", makeChar("林", "DD", Some(["木", "木"]), ())),
  ("杜", makeChar("杜", "DG", Some(["木", "土"]), ())),
  ("寸", makeChar("寸", "DI", Some(["木", "戈"]), ())),
  ("末", makeChar("末", "DJ", Some(["木", "十"]), ())),
  ("東", makeChar("東", "DW", Some(["木", "田"]), ())),
  ("沐", makeChar("沐", "ED", Some(["水", "木"]), ())),
  ("圣", makeChar("圣", "EG", Some(["水", "土"]), ())),
  ("汉", makeChar("汉", "EE", Some(["水", "水"]), ())),
  ("江", makeChar("江", "EM", Some(["水", "一"]), ())),
  ("肖", makeChar("肖", "FB", Some(["火", "月"]), ())),
  ("灶", makeChar("灶", "FG", Some(["火", "土"]), ())),
  ("炎", makeChar("炎", "FF", Some(["火", "火"]), ())),
  ("小", makeChar("小", "NC", Some(["弓", "金"]), ())),
  ("少", makeChar("少", "FH", Some(["火", "竹"]), ())),
  ("去", makeChar("去", "GI", Some(["土", "戈"]), ())),
  ("白", makeChar("白", "HA", Some(["竹", "日"]), ())),
  ("禾", makeChar("禾", "HD", Some(["竹", "木"]), ())),
  ("千", makeChar("千", "HJ", Some(["竹", "十"]), ())),
  ("八", makeChar("八", "HO", Some(["竹", "人"]), ())),
  ("戊", makeChar("戊", "IH", Some(["戈", "竹"]), ())),
  ("床", makeChar("床", "ID", Some(["戈", "木"]), ())),
  ("支", makeChar("支", "JE", Some(["十", "水"]), ())),
  ("古", makeChar("古", "JR", Some(["口", "十", "口"]), ())),
  ("有", makeChar("有", "KB", Some(["大", "月"]), ())),
  ("友", makeChar("友", "KE", Some(["大", "水"]), ())),
  ("灰", makeChar("灰", "KF", Some(["大", "火"]), ())),
  ("太", makeChar("太", "KI", Some(["大", "戈"]), ())),
  ("右", makeChar("右", "KR", Some(["大", "口"]), ())),
  ("串", makeChar("串", "LL", Some(["中", "中"]), ())),
  ("由", makeChar("由", "LW", Some(["中", "田"]), ())),
  ("天", makeChar("天", "MK", Some(["一", "大"]), ())),
  ("二", makeChar("二", "MM", Some(["一", "一"]), ())),
  ("石", makeChar("石", "MR", Some(["一", "口"]), ())),
  ("下", makeChar("下", "MY", Some(["一", "卜"]), ())),
  ("弔", makeChar("弔", "NL", Some(["弓", "中"]), ())),
  ("引", makeChar("引", "NL", Some(["弓", "中"]), ())),
  ("入", makeChar("入", "OH", Some(["人", "竹"]), ())),
  ("个", makeChar("个", "OL", Some(["人", "中"]), ())),
  ("必", makeChar("必", "PH", Some(["竹", "心"]), ())),
  ("世", makeChar("世", "PT", Some(["心", "廿"]), ())),
  ("屯", makeChar("屯", "PU", Some(["心", "山"]), ())),
  ("扣", makeChar("扣", "QR", Some(["手", "口"]), ())),
  ("呆", makeChar("呆", "RD", Some(["口", "木"]), ())),
  ("尺", makeChar("尺", "SO", Some(["尸", "戈"]), ())),
  ("尼", makeChar("尼", "SP", Some(["尸", "心"]), ())),
  ("共", makeChar("共", "TC", Some(["廿", "金"]), ())),
  ("卅", makeChar("卅", "TJ", Some(["廿", "一"]), ())),
  ("出", makeChar("出", "UU", Some(["山", "山"]), ())),
  ("如", makeChar("如", "VR", Some(["女", "口"]), ())),
  ("困", makeChar("困", "WD", Some(["田", "木"]), ())),
  ("因", makeChar("因", "WK", Some(["田", "大"]), ())),
  ("甲", makeChar("甲", "WL", Some(["田", "中"]), ())),
  ("思", makeChar("思", "WP", Some(["田", "心"]), ())),
  ("回", makeChar("回", "WR", Some(["田", "口"]), ())),
  ("上", makeChar("上", "YM", Some(["卜", "一"]), ())),
  ("占", makeChar("占", "YR", Some(["卜", "口"]), ())),
  ("丈", makeChar("丈", "JK", Some(["十", "大"]), ())),

  // 3-key characters
  ("同", makeChar("同", "BMR", Some(["月", "一", "口"]), ())),
  ("森", makeChar("森", "DDD", Some(["木", "木", "木"]), ())),
  ("焚", makeChar("焚", "DDF", Some(["火", "火"]), ())),
  ("桂", makeChar("桂", "DGG", Some(["木", "土", "土"]), ())),
  ("消", makeChar("消", "EFB", Some(["水", "火", "月"]), ())),
  ("脊", makeChar("脊", "FCB", Some(["火", "金", "月"]), ())),
  ("竺", makeChar("竺", "HMM", Some(["竹", "土"]), ())),
  ("成", makeChar("成", "IHS", Some(["戈", "十"]), ())),
  ("或", makeChar("或", "IRM", Some(["戈", "口", "一"]), ())),
  ("鹿", makeChar("鹿", "IXP", Some(["難", "戈", "難", "心"]), ())),
  ("字", makeChar("字", "JND", Some(["十", "弓", "木"]), ())),
  ("車", makeChar("車", "JWJ", Some(["十", "田", "十"]), ())),
  ("夾", makeChar("夾", "KOO", Some(["大", "人", "人"]), ())),
  ("央", makeChar("央", "LBK", Some(["中", "月", "大"]), ())),
  ("書", makeChar("書", "LGA", Some(["中", "土", "日"]), ())),
  ("川", makeChar("川", "LLL", Some(["中", "中", "中"]), ())),
  ("弗", makeChar("弗", "LLN", Some(["中", "中", "弓"]), ())),
  ("申", makeChar("申", "LWL", Some(["中", "中"]), ())),
  ("工", makeChar("工", "MLM", Some(["一", "中", "一"]), ())),
  ("三", makeChar("三", "MMM", Some(["一", "一", "一"]), ())),
  ("可", makeChar("可", "MNR", Some(["一", "弓", "口"]), ())),
  ("外", makeChar("外", "NIY", Some(["弓", "戈", "卜"]), ())),
  ("你", makeChar("你", "ONF", Some(["人", "弓", "火"]), ())),
  ("他", makeChar("他", "OPD", Some(["人", "心", "木"]), ())),
  ("拿", makeChar("拿", "ORQ", Some(["人", "口", "手"]), ())),
  ("怕", makeChar("怕", "PHA", Some(["心", "竹", "日"]), ())),
  ("打", makeChar("打", "QMN", Some(["手", "一", "弓"]), ())),
  ("局", makeChar("局", "SSR", Some(["尸", "尸", "口"]), ())),
  ("草", makeChar("草", "TAJ", Some(["廿", "日"]), ())),
  ("若", makeChar("若", "TKR", Some(["廿", "口"]), ())),
  ("岐", makeChar("岐", "UJE", Some(["山", "十", "竹"]), ())),
  ("樂", makeChar("樂", "VID", Some(["女", "戈", "木"]), ())),
  ("好", makeChar("好", "VND", Some(["女", "弓", "木"]), ())),
  ("妃", makeChar("妃", "VSU", Some(["女", "尸", "山"]), ())),
  ("男", makeChar("男", "WKS", Some(["田", "大", "尸"]), ())),
  ("卡", makeChar("卡", "YMY", Some(["卜", "一", "卜"]), ())),

  // 4-key characters
  ("愛", makeChar("愛", "BBPE", Some(["月", "月", "心", "水"]), ())),
  ("樹", makeChar("樹", "DGTI", Some(["木", "土", "廿", "戈"]), ())),
  ("橋", makeChar("橋", "DHKB", Some(["木", "竹", "大", "月"]), ())),
  ("權", makeChar("權", "DTRG", Some(["木", "廿", "口", "土"]), ())),
  ("機", makeChar("機", "DVII", Some(["木", "女", "戈", "戈"]), ())),
  ("河", makeChar("河", "EMNR", Some(["水", "一", "弓", "口"]), ())),
  ("學", makeChar("學", "HBND", Some(["竹", "月", "弓", "木"]), ())),
  ("重", makeChar("重", "HJWG", Some(["竹", "十", "田", "土"]), ())),
  ("與", makeChar("與", "HXYC", Some(["竹", "難", "卜", "金"]), ())),
  ("為", makeChar("為", "IKNF", Some(["戈", "大", "弓", "火"]), ())),
  ("爾", makeChar("爾", "MFBK", Some(["一", "火", "月", "大"]), ())),
  ("個", makeChar("個", "OWJR", Some(["人", "田", "十", "口"]), ())),
  ("羣", makeChar("羣", "SRTQ", Some(["尸", "口", "廿", "手"]), ())),
  ("華", makeChar("華", "TMTJ", Some(["廿", "一", "廿", "十"]), ())),
  ("難", makeChar("難", "TOOG", Some(["廿", "人", "人", "土"]), ())),
  ("藥", makeChar("藥", "TVID", Some(["廿", "女", "戈", "木"]), ())),
  ("變", makeChar("變", "VFOK", Some(["女", "火", "人", "大"]), ())),
  ("巢", makeChar("巢", "VVWD", Some(["難", "難", "竹", "木", "月"]), ())),
  ("園", makeChar("園", "WGRV", Some(["田", "土", "口", "女"]), ())),
  ("國", makeChar("國", "WIRM", Some(["田", "戈", "口", "一"]), ())),
  ("課", makeChar("課", "YRWD", Some(["卜", "口", "田", "木"]), ())),
  ("意", makeChar("意", "YTAP", Some(["卜", "廿", "日", "心"]), ())),

  // 5-key characters
  ("卵", makeChar("卵", "HHSLI", Some(["難", "竹", "手", "火"]), ())),
  ("從", makeChar("從", "HOOOO", Some(["人", "人"]), ())),
  ("拜", makeChar("拜", "HQMQJ", Some(["竹", "手", "一", "手", "十"]), ())),
  ("弱", makeChar("弱", "NMNIM", Some(["弓", "弓"]), ())),
  ("義", makeChar("義", "TGHQI", Some(["廿", "土", "竹", "手", "戈"]), ())),
  ("贏", makeChar("贏", "YNBUC", Some(["卜", "弓", "月", "山", "金"]), ())),
  ("謝", makeChar("謝", "YRHHI", Some(["卜", "口", "竹", "竹", "戈"]), ())),
  ("請", makeChar("請", "YRQMB", Some(["卜", "口", "手", "一", "月"]), ())),
])

// Helper function to get a character from the dictionary
let char = (c: string): characterInfo => {
  switch Belt.Map.String.get(characterDictionary, c) {
  | Some(charInfo) => charInfo
  | None => {
      // This should never happen if the dictionary is complete
      Js.Exn.raiseError("Character \"" ++ c ++ "\" not found in dictionary")
    }
  }
}

// PHILOSOPHY (哲理類) - Lessons 1-7
// Lesson 1: 日 - Learn A (日) - Can only use: A
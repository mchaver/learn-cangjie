// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

let lesson25Characters = [
  // X is used for difficult/special characters
  char("卵"),
  char("卵"),
  char("巢"),
  char("巢"),
  char("鹿"),
  char("鹿"),
  // Practice mix
  char("卵"),
  char("巢"),
  char("鹿"),
  char("卵"),
]

// Lesson 26: 重 - Learn Z (重)
let lesson26Characters = [
  // Z is the repeat key - used when a shape repeats
  char("昌"),
  char("昌"),
  char("朋"),
  char("朋"),
  char("林"),
  char("林"),
  char("炎"),
  char("炎"),
  char("從"),
  char("從"),
  char("出"),
  char("出"),
]

// Application lessons - multi-character words using learned radicals

// Philosophy Application: Only uses A-G (日月金木水火土)
let philosophyApplicationCharacters = [
  // Practice double radicals
  char("明"), // bright/tomorrow
  char("昌"), // prosperous
  char("朋"), // friend
  char("林"), // forest
  char("炎"), // flame/inflammation
  char("汉"), // Han Chinese
  // More combinations with A-G only
  char("杜"), // Du (surname), prevent
  char("杲"), // bright (archaic) - Fixed: AD not DA
  char("杳"), // dark/obscure
  char("焚"), // burn
  // Removed characters that use keys beyond A-G:
  // 柏 (DHA uses H), 析 (DHML uses H,M,L), 枝 (DJE uses J),
  // 杏 (DR uses R), 朴 (DY uses Y), 灿 (FU uses U)
  // Mix practice - reinforce the basics
  char("明"),
  char("林"),
  char("炎"),
  char("汉"),
  char("朋"),
  char("昌"),
  char("杜"),
  char("杲"),
  char("杳"),
]

// Strokes Application: Only uses A-N (日月金木水火土竹戈十大中一弓)
let strokesApplicationCharacters = [
  char("早"), // early/morning
  char("末"), // end
  char("友"), // friend
  char("炎"), // flame
  char("汉"), // Han
  char("灰"), // ash/grey
  char("支"), // support/branch
  char("去"), // go
  char("公"), // public
  char("白"), // white
  char("千"), // thousand
  char("禾"), // grain/rice
  char("少"), // few/little
  char("寸"), // inch
  char("引"), // pull/guide
  char("弱"), // weak
  char("天"), // sky/heaven
  char("旦"), // dawn
  char("成"), // become
  char("有"), // have
]

// Body Parts Application: Only uses A-R (all previous + 人心手口)
let bodyPartsApplicationCharacters = [
  char("同"), // same
  char("右"), // right
  char("石"), // stone
  char("呆"), // dull/stay
  char("个"), // MW/individual
  char("八"), // eight
  char("從"), // from/follow
  char("必"), // must
  char("扣"), // button/knock
]

// Shapes Application: Only uses A-Y (all previous + 尸廿山女田卜)
let shapesApplicationCharacters = [
  char("早"), // early
  char("白"), // white
  char("同"), // same
  char("出"), // out/exit
  char("好"), // good
  char("上"), // up/above
  char("下"), // down/below
  char("占"), // occupy/divine
  char("若"), // if/like
  char("草"), // grass
  char("東"), // east
  char("由"), // by/from
]

// PATTERN EXPLORATION - Teach character decomposition and structure
// These lessons bridge from radical learning to common characters
// Focus: How keys represent different components in actual characters

// Lesson 26: Simple Two-Key Combinations
// Introduction to how two radicals combine to form characters
let simplePatternCharacters = [
  // Double radicals (same key twice)
  char("明"), // bright: sun + moon
  char("明"),
  char("林"), // forest: two trees
  char("林"),
  char("炎"), // flame: two fires
  char("炎"),

  // Simple left-right combinations
  char("好"), // good: woman + child
  char("好"),
  char("如"), // if: woman + mouth
  char("如"),
  char("杜"), // surname Du: wood + earth
  char("杜"),

  // Top-bottom combinations
  char("早"), // early: sun over ten
  char("早"),
  char("草"), // grass: grass radical + early
  char("草"),

  // Mix practice
  char("明"),
  char("林"),
  char("好"),
  char("早"),
]

// Lesson 27: Three-Key Character Patterns
// Characters requiring three inputs - more complex decomposition
let threeKeyPatternCharacters = [
  // Three components arranged vertically
  char("草"), // grass
  char("草"),
  char("若"), // if/like
  char("若"),

  // Three components arranged horizontally and vertically
  char("男"), // male: field + strength
  char("男"),
  char("字"), // character
  char("字"),

  // Three keys with meaning
  char("共"), // together
  char("共"),
  char("石"), // stone
  char("石"),
  char("古"), // ancient
  char("古"),

  // Mix practice
  char("草"),
  char("男"),
  char("字"),
  char("古"),
]

// Lesson 28: Enclosures and Special Structures
// Understanding outside→inside, left→right rules for enclosed structures
let enclosurePatternCharacters = [
  // Full enclosures (type outside first)
  char("回"), // return: enclosure + mouth
  char("回"),
  char("因"), // because: enclosure + big
  char("因"),
  char("困"), // difficult: enclosure + wood
  char("困"),

  // Partial enclosures
  char("同"), // same: enclosure with opening
  char("同"),

  // Complex enclosed structures
  makeChar("日", "A", None, ()), // sun (single key, full enclosure)
  makeChar("日", "A", None, ()),
  makeChar("月", "B", None, ()), // moon (single key)
  makeChar("月", "B", None, ()),
  makeChar("田", "W", None, ()), // field (single key, grid structure)
  makeChar("田", "W", None, ()),

  // Top-to-bottom with enclosure
  char("早"), // early: sun over ten
  char("早"),

  // Mix practice
  char("回"),
  char("因"),
  char("同"),
  char("早"),
]

// Lesson 29: Mixed Pattern Practice
// Comprehensive review of all pattern types
let mixedPatternCharacters = [
  // Review all patterns learned
  char("明"), // double radicals
  char("林"),
  char("炎"),

  char("好"), // left-right
  char("如"),
  char("杜"),

  char("早"), // top-bottom
  char("草"),

  char("男"), // three-key patterns
  char("字"),
  char("古"),

  char("回"), // enclosures
  char("因"),
  char("困"),
  char("同"),

  // Final mix
  char("明"),
  char("好"),
  char("草"),
  char("回"),
]

// Lesson 30: Four-Key Complex Patterns
// Characters with 4 keys showing various structural combinations
let fourKeyPatternCharacters = [
  // Four keys: complex left-right structures
  char("謝"), // thanks: speech + body
  char("謝"),
  char("請"), // please: speech + invite
  char("請"),
  char("課"), // lesson: speech + fruit
  char("課"),

  // Four keys: complex top-bottom structures
  char("思"), // think: field + heart
  char("思"),
  char("意"), // meaning: sound + heart
  char("意"),
  char("愛"), // love: claw + heart + walk
  char("愛"),

  // Four keys: enclosed structures
  char("國"), // country: enclosure + jade
  char("國"),
  char("園"), // garden: enclosure + yuan
  char("園"),

  // Mix practice
  char("謝"),
  char("思"),
  char("國"),
  char("意"),
]

// Lesson 31: Five-Key Maximum Complexity
// The most complex characters use all 5 keys (first-second-third-last rule)
let fiveKeyPatternCharacters = [
  // Understanding the first-last rule for complex characters
  char("樹"), // tree: wood + bean + inch
  char("樹"),
  char("樂"), // music/joy: white + wood
  char("樂"),
  char("藥"), // medicine: grass + music
  char("藥"),

  // Five key characters with complex radicals
  char("機"), // machine: wood + chance
  char("機"),
  char("橋"), // bridge: wood + high
  char("橋"),
  char("權"), // power/right: wood + authority
  char("權"),

  // Characters showing first-second-third-last selection
  char("難"), // difficult: many components
  char("難"),
  char("變"), // change: complex structure
  char("變"),

  // Mix practice
  char("樹"),
  char("藥"),
  char("難"),
  char("機"),
]

// Lesson 32: Connected vs Disconnected Components
// Understanding when strokes are considered connected or separate
let connectedComponentsCharacters = [
  // Connected components count as one radical
  char("木"), // wood: connected strokes
  char("木"),
  char("林"), // forest: two separate woods
  char("林"),
  char("日"), // sun: connected enclosure
  char("日"),

  // Disconnected components are separate radicals
  char("八"), // eight: two separated strokes
  char("八"),
  char("小"), // small: disconnected vertical + dots
  char("小"),
  char("川"), // river: three separate strokes
  char("川"),

  // Characters where connection matters
  char("口"), // mouth: connected enclosure (1 key)
  char("口"),
  char("人"), // person: connected strokes (1 key)
  char("人"),
  char("個"), // individual: person + solid
  char("個"),

  // Mix practice
  char("林"),
  char("八"),
  char("川"),
  char("個"),
]

// Lesson 33: First-Last Rule Deep Dive
// Understanding how to handle characters with many components
let firstLastRuleCharacters = [
  // Two components: take all keys
  char("明"), // 2 components: both keys
  char("明"),
  char("林"), // 2 components: both keys
  char("林"),

  // Three components: take all keys
  char("草"), // 3 components: all keys
  char("草"),
  char("思"), // 2 components: field + heart
  char("思"),

  // Five+ strokes: first, second, third, last
  char("難"), // many strokes: 1st,2nd,3rd,last
  char("難"),
  char("贏"), // win: complex character
  char("贏"),

  // Understanding which strokes to count
  char("爾"), // you (formal): many parts
  char("爾"),
  char("華"), // magnificent: flower radical
  char("華"),

  // Practice characters showing the rule
  char("義"), // righteousness/meaning
  char("義"),
  char("羣"), // group (variant)
  char("羣"),

  // Mix practice
  char("難"),
  char("贏"),
  char("華"),
  char("義"),
]

// Lesson 34: Radical Variations
// Same radical appears differently based on position
let radicalVariationCharacters = [
  // 人 (O) vs 亻(O) - person radical in different positions
  char("人"), // person standalone
  char("人"),
  char("你"), // you: person + you
  char("你"),
  char("他"), // he: person + also
  char("他"),

  // 水 (E) vs 氵(E) - water radical variations
  char("水"), // water standalone
  char("水"),
  char("河"), // river: water + can
  char("河"),
  char("江"), // river: water + work
  char("江"),

  // 心 (P) vs 忄(P) vs ⺗(P) - heart radical variations
  char("心"), // heart standalone
  char("心"),
  char("怕"), // fear: heart + white
  char("怕"),
  char("思"), // think: heart at bottom
  char("思"),

  // 手 (Q) vs 扌(Q) - hand radical variations
  char("手"), // hand standalone
  char("手"),
  char("打"), // hit: hand + nail
  char("打"),
  char("拿"), // take: hand + together
  char("拿"),

  // Mix practice
  char("你"),
  char("河"),
  char("思"),
  char("打"),
]

// Lesson 35: Exception Characters and Special Cases
// Characters that don't follow obvious patterns - learn by memory
let exceptionCharacters = [
  // Common exceptions that trip up learners
  char("必"), // must: heart + stroke (not obvious)
  char("必"),
  char("世"), // world: unusual decomposition
  char("世"),
  char("或"), // or: complex breakdown
  char("或"),

  // Characters where radical isn't obvious
  char("重"), // heavy/repeat: not intuitive
  char("重"),
  char("書"), // book: special form
  char("書"),
  char("車"), // car/vehicle: symmetrical
  char("車"),

  // Simplified vs traditional differences
  char("學"), // study: complex traditional
  char("學"),
  char("愛"), // love: has claw + heart
  char("愛"),

  // Characters with hidden components
  char("為"), // for/do: hand + elephant
  char("為"),
  char("與"), // give/and: unusual
  char("與"),

  // Mix practice - memorize these!
  char("必"),
  char("重"),
  char("學"),
  char("為"),
]

// Lesson 36: Comprehensive Pattern Review
// Mix all patterns learned in lessons 26-35
let comprehensivePatternReview = [
  // Simple patterns (Lesson 26-27)
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("林", "DD", Some(["木", "木"]), ()),
  makeChar("草", "TAJ", Some(["廿", "日", "十"]), ()),
  makeChar("字", "JND", Some(["十", "弓", "木"]), ()),

  // Enclosures (Lesson 28)
  makeChar("回", "WR", Some(["田", "口"]), ()),
  makeChar("因", "WK", Some(["田", "大"]), ()),
  makeChar("同", "BMR", Some(["月", "一", "口"]), ()),

  // Four-key patterns (Lesson 30)
  makeChar("謝", "YRHHI", Some(["卜", "口", "竹", "竹", "戈"]), ()),
  makeChar("思", "WP", Some(["田", "心"]), ()),
  makeChar("國", "WIRM", Some(["田", "戈", "口", "一"]), ()),

  // Five-key complexity (Lesson 31)
  makeChar("難", "TOOG", Some(["廿", "人", "人", "土"]), ()),
  makeChar("樹", "DGTI", Some(["木", "土", "廿", "戈"]), ()),

  // Connected components (Lesson 32)
  makeChar("八", "HO", Some(["竹", "人"]), ()),
  makeChar("川", "LLL", Some(["中", "中", "中"]), ()),

  // First-last rule (Lesson 33)
  makeChar("贏", "YNBUC", Some(["卜", "弓", "月", "山", "金"]), ()),
  makeChar("華", "TMTJ", Some(["廿", "一", "廿", "十"]), ()),

  // Radical variations (Lesson 34)
  makeChar("你", "ONF", Some(["人", "弓", "火"]), ()),
  makeChar("河", "EMNR", Some(["水", "一", "弓", "口"]), ()),
  makeChar("打", "QMN", Some(["手", "一", "弓"]), ()),

  // Exceptions (Lesson 35)
  makeChar("必", "PH", Some(["心", "竹"]), ()),
  makeChar("重", "HJWG", Some(["竹", "十", "田", "土"]), ()),
  makeChar("學", "HBND", Some(["竹", "月", "弓", "木"]), ()),

  // Final comprehensive mix
  makeChar("明", "AB", Some(["日", "月"]), ()),
  makeChar("國", "WIRM", Some(["田", "戈", "口", "一"]), ()),
  makeChar("難", "TOOG", Some(["廿", "人", "人", "土"]), ()),
  makeChar("思", "WP", Some(["田", "心"]), ()),
  makeChar("為", "IKNF", Some(["戈", "大", "弓", "火"]), ()),
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
  makeChar("這", "YYMR", None, ~frequencyRank=11, ()),
  makeChar("這", "YYMR", None, ~frequencyRank=11, ()),
  makeChar("這", "YYMR", None, ~frequencyRank=11, ()),
  makeChar("為", "IKNF", None, ~frequencyRank=12, ()),
  makeChar("為", "IKNF", None, ~frequencyRank=12, ()),
  makeChar("為", "IKNF", None, ~frequencyRank=12, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("來", "DOO", None, ~frequencyRank=15, ()),
  makeChar("來", "DOO", None, ~frequencyRank=15, ()),
  makeChar("來", "DOO", None, ~frequencyRank=15, ()),
  // Mix practice
  makeChar("這", "YYMR", None, ~frequencyRank=11, ()),
  makeChar("為", "IKNF", None, ~frequencyRank=12, ()),
  makeChar("之", "INO", None, ~frequencyRank=13, ()),
  makeChar("大", "K", None, ~frequencyRank=14, ()),
  makeChar("來", "DOO", None, ~frequencyRank=15, ()),
]

let commonChars4 = [  // 以個中上們
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("個", "OWJR", None, ~frequencyRank=17, ()),
  makeChar("個", "OWJR", None, ~frequencyRank=17, ()),
  makeChar("個", "OWJR", None, ~frequencyRank=17, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("們", "OAN", None, ~frequencyRank=20, ()),
  makeChar("們", "OAN", None, ~frequencyRank=20, ()),
  makeChar("們", "OAN", None, ~frequencyRank=20, ()),
  // Mix practice
  makeChar("以", "VIO", None, ~frequencyRank=16, ()),
  makeChar("個", "OWJR", None, ~frequencyRank=17, ()),
  makeChar("中", "L", None, ~frequencyRank=18, ()),
  makeChar("上", "YM", None, ~frequencyRank=19, ()),
  makeChar("們", "OAN", None, ~frequencyRank=20, ()),
]

// SET 2: Characters 21-40
let commonChars5 = [  // 到說國和地
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("說", "YRCRU", None, ~frequencyRank=22, ()),
  makeChar("說", "YRCRU", None, ~frequencyRank=22, ()),
  makeChar("說", "YRCRU", None, ~frequencyRank=22, ()),
  makeChar("國", "WIRM", None, ~frequencyRank=23, ()),
  makeChar("國", "WIRM", None, ~frequencyRank=23, ()),
  makeChar("國", "WIRM", None, ~frequencyRank=23, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("和", "HDR", None, ~frequencyRank=24, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  makeChar("地", "GPD", None, ~frequencyRank=25, ()),
  // Mix practice
  makeChar("到", "MGLN", None, ~frequencyRank=21, ()),
  makeChar("說", "YRCRU", None, ~frequencyRank=22, ()),
  makeChar("國", "WIRM", None, ~frequencyRank=23, ()),
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
  makeChar("時", "AGDI", None, ~frequencyRank=28, ()),
  makeChar("時", "AGDI", None, ~frequencyRank=28, ()),
  makeChar("時", "AGDI", None, ~frequencyRank=28, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("道", "YTHU", None, ~frequencyRank=29, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  makeChar("出", "UU", None, ~frequencyRank=30, ()),
  // Mix practice
  makeChar("也", "PD", None, ~frequencyRank=26, ()),
  makeChar("子", "ND", None, ~frequencyRank=27, ()),
  makeChar("時", "AGDI", None, ~frequencyRank=28, ()),
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
  makeChar("於", "YSOY", None, ~frequencyRank=33, ()),
  makeChar("於", "YSOY", None, ~frequencyRank=33, ()),
  makeChar("於", "YSOY", None, ~frequencyRank=33, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("就", "YFIKU", None, ~frequencyRank=34, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  makeChar("下", "MY", None, ~frequencyRank=35, ()),
  // Mix practice
  makeChar("而", "MBLL", None, ~frequencyRank=31, ()),
  makeChar("要", "MWV", None, ~frequencyRank=32, ()),
  makeChar("於", "YSOY", None, ~frequencyRank=33, ()),
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
  makeChar("會", "OMWA", None, ~frequencyRank=42, ()),
  makeChar("會", "OMWA", None, ~frequencyRank=42, ()),
  makeChar("會", "OMWA", None, ~frequencyRank=42, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("後", "HOVIE", None, ~frequencyRank=44, ()),
  makeChar("後", "HOVIE", None, ~frequencyRank=44, ()),
  makeChar("後", "HOVIE", None, ~frequencyRank=44, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
  // Mix practice
  makeChar("自", "HBU", None, ~frequencyRank=41, ()),
  makeChar("會", "OMWA", None, ~frequencyRank=42, ()),
  makeChar("那", "SQNL", None, ~frequencyRank=43, ()),
  makeChar("後", "HOVIE", None, ~frequencyRank=44, ()),
  makeChar("能", "IBPP", None, ~frequencyRank=45, ()),
]

let commonChars10 = [  // 對著事其里
  makeChar("對", "TGDI", None, ~frequencyRank=46, ()),
  makeChar("對", "TGDI", None, ~frequencyRank=46, ()),
  makeChar("對", "TGDI", None, ~frequencyRank=46, ()),
  makeChar("著", "TJKA", None, ~frequencyRank=47, ()),
  makeChar("著", "TJKA", None, ~frequencyRank=47, ()),
  makeChar("著", "TJKA", None, ~frequencyRank=47, ()),
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
  makeChar("對", "TGDI", None, ~frequencyRank=46, ()),
  makeChar("著", "TJKA", None, ~frequencyRank=47, ()),
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
  makeChar("過", "YBBR", None, ~frequencyRank=54, ()),
  makeChar("過", "YBBR", None, ~frequencyRank=54, ()),
  makeChar("過", "YBBR", None, ~frequencyRank=54, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
  // Mix practice
  makeChar("所", "HSHML", None, ~frequencyRank=51, ()),
  makeChar("去", "GI", None, ~frequencyRank=52, ()),
  makeChar("行", "HOMMN", None, ~frequencyRank=53, ()),
  makeChar("過", "YBBR", None, ~frequencyRank=54, ()),
  makeChar("家", "JMSO", None, ~frequencyRank=55, ()),
]

let commonChars12 = [  // 十用發天如
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("發", "NONHE", None, ~frequencyRank=58, ()),
  makeChar("發", "NONHE", None, ~frequencyRank=58, ()),
  makeChar("發", "NONHE", None, ~frequencyRank=58, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("天", "MK", None, ~frequencyRank=59, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  makeChar("如", "VR", None, ~frequencyRank=60, ()),
  // Mix practice
  makeChar("十", "J", None, ~frequencyRank=56, ()),
  makeChar("用", "BQ", None, ~frequencyRank=57, ()),
  makeChar("發", "NONHE", None, ~frequencyRank=58, ()),
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
  makeChar("經", "VFMVM", None, ~frequencyRank=72, ()),
  makeChar("經", "VFMVM", None, ~frequencyRank=72, ()),
  makeChar("經", "VFMVM", None, ~frequencyRank=72, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("當", "FBRW", None, ~frequencyRank=74, ()),
  makeChar("當", "FBRW", None, ~frequencyRank=74, ()),
  makeChar("當", "FBRW", None, ~frequencyRank=74, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
  // Mix practice
  makeChar("已", "SU", None, ~frequencyRank=71, ()),
  makeChar("經", "VFMVM", None, ~frequencyRank=72, ()),
  makeChar("法", "EGI", None, ~frequencyRank=73, ()),
  makeChar("當", "FBRW", None, ~frequencyRank=74, ()),
  makeChar("起", "GORU", None, ~frequencyRank=75, ()),
]

// SET 5: Characters 76-90
let commonChars16 = [  // 與好看學進
  makeChar("與", "HXYC", None, ~frequencyRank=76, ()),
  makeChar("與", "HXYC", None, ~frequencyRank=76, ()),
  makeChar("與", "HXYC", None, ~frequencyRank=76, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("學", "HBND", None, ~frequencyRank=79, ()),
  makeChar("學", "HBND", None, ~frequencyRank=79, ()),
  makeChar("學", "HBND", None, ~frequencyRank=79, ()),
  makeChar("進", "YOG", None, ~frequencyRank=80, ()),
  makeChar("進", "YOG", None, ~frequencyRank=80, ()),
  makeChar("進", "YOG", None, ~frequencyRank=80, ()),
  // Mix practice
  makeChar("與", "HXYC", None, ~frequencyRank=76, ()),
  makeChar("好", "VND", None, ~frequencyRank=77, ()),
  makeChar("看", "HQBU", None, ~frequencyRank=78, ()),
  makeChar("學", "HBND", None, ~frequencyRank=79, ()),
  makeChar("進", "YOG", None, ~frequencyRank=80, ()),
]

let commonChars17 = [  // 種將還分此
  makeChar("種", "HDHJG", None, ~frequencyRank=81, ()),
  makeChar("種", "HDHJG", None, ~frequencyRank=81, ()),
  makeChar("種", "HDHJG", None, ~frequencyRank=81, ()),
  makeChar("將", "VMBDI", None, ~frequencyRank=82, ()),
  makeChar("將", "VMBDI", None, ~frequencyRank=82, ()),
  makeChar("將", "VMBDI", None, ~frequencyRank=82, ()),
  makeChar("還", "YWLV", None, ~frequencyRank=83, ()),
  makeChar("還", "YWLV", None, ~frequencyRank=83, ()),
  makeChar("還", "YWLV", None, ~frequencyRank=83, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("分", "CSH", None, ~frequencyRank=84, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  makeChar("此", "YMP", None, ~frequencyRank=85, ()),
  // Mix practice
  makeChar("種", "HDHJG", None, ~frequencyRank=81, ()),
  makeChar("將", "VMBDI", None, ~frequencyRank=82, ()),
  makeChar("還", "YWLV", None, ~frequencyRank=83, ()),
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
  makeChar("見", "BUHU", None, ~frequencyRank=91, ()),
  makeChar("見", "BUHU", None, ~frequencyRank=91, ()),
  makeChar("見", "BUHU", None, ~frequencyRank=91, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("沒", "ENE", None, ~frequencyRank=94, ()),
  makeChar("沒", "ENE", None, ~frequencyRank=94, ()),
  makeChar("沒", "ENE", None, ~frequencyRank=94, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("從", "HOOOO", None, ~frequencyRank=96, ()),
  makeChar("從", "HOOOO", None, ~frequencyRank=96, ()),
  makeChar("從", "HOOOO", None, ~frequencyRank=96, ()),
  // Mix practice - all 6 characters
  makeChar("見", "BUHU", None, ~frequencyRank=91, ()),
  makeChar("只", "RC", None, ~frequencyRank=92, ()),
  makeChar("主", "YG", None, ~frequencyRank=93, ()),
  makeChar("沒", "ENE", None, ~frequencyRank=94, ()),
  makeChar("公", "CI", None, ~frequencyRank=95, ()),
  makeChar("從", "HOOOO", None, ~frequencyRank=96, ()),
]

// Placement test characters (mix of all difficulty levels)
let placementTestChars = [
  makeChar("我", "HQI", None, ()),
  makeChar("你", "ONF", None, ()),
  makeChar("他", "OPD", None, ()),
  makeChar("是", "AMYO", None, ()),
  makeChar("的", "HAPI", None, ()),
  makeChar("了", "NN", None, ()),
  makeChar("在", "KLG", None, ()),
  makeChar("有", "KB", None, ()),
  makeChar("和", "HDR", None, ()),
  makeChar("到", "MGLN", None, ()),
  makeChar("說", "YRCRU", None, ()),
  makeChar("要", "MWV", None, ()),
  makeChar("會", "OMWA", None, ()),
  makeChar("能", "IBPP", None, ()),
  makeChar("出", "UU", None, ()),
]

// Generate all lessons

let getAdvancedLessons = (): array<Types.lesson> => {
  let advancedLessons = [
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

    // SECTION 5.5: PATTERN EXPLORATION (拆字探索) - Lessons 26-29
    // Bridge between radical learning and common characters
    // Focus: Character decomposition patterns and structural understanding

    // Lesson 26: Simple Two-Key Combinations
    makeLesson(26, "拆字探索 1：簡單組合", "學習雙部首組字規則",
      Advanced, CommonWords, Practice, [],
      simplePatternCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 27: Three-Key Character Patterns
    makeLesson(27, "拆字探索 2：三鍵字型", "學習三部首組字規則",
      Advanced, CommonWords, Practice, [],
      threeKeyPatternCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 28: Enclosures and Special Structures
    makeLesson(28, "拆字探索 3：包圍結構", "學習包圍結構的拆字規則",
      Advanced, CommonWords, Practice, [],
      enclosurePatternCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 29: Mixed Pattern Practice
    makeLesson(29, "拆字探索 4：綜合練習", "綜合複習所有拆字規則",
      Advanced, CommonWords, MixedReview, [],
      mixedPatternCharacters, ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28], ()),

    // Lesson 30: Four-Key Complex Patterns
    makeLesson(30, "拆字探索 5：四鍵複合", "學習四鍵複雜字型結構",
      Advanced, CommonWords, Practice, [],
      fourKeyPatternCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 31: Five-Key Maximum Complexity
    makeLesson(31, "拆字探索 6：五鍵最複雜", "掌握五鍵最複雜字型與首尾規則",
      Advanced, CommonWords, Practice, [],
      fiveKeyPatternCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 32: Connected vs Disconnected Components
    makeLesson(32, "拆字探索 7：連接與分離", "理解筆畫連接與分離的判斷",
      Advanced, CommonWords, Practice, [],
      connectedComponentsCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 33: First-Last Rule Deep Dive
    makeLesson(33, "拆字探索 8：首尾規則深入", "深入學習處理多部件字的方法",
      Advanced, CommonWords, Practice, [],
      firstLastRuleCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 34: Radical Variations
    makeLesson(34, "拆字探索 9：部首變形", "理解部首在不同位置的變化",
      Advanced, CommonWords, Practice, [],
      radicalVariationCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 35: Exception Characters
    makeLesson(35, "拆字探索 10：特殊例外字", "記憶不遵循常規的特殊字",
      Advanced, CommonWords, Practice, [],
      exceptionCharacters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 36: Comprehensive Pattern Review
    makeLesson(36, "拆字探索 11：全面複習", "全面複習26-35課所有拆字規則",
      Advanced, CommonWords, MixedReview, [],
      comprehensivePatternReview, ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26, 27, 28, 29, 30, 31, 32, 33, 34, 35], ()),
  ]
  advancedLessons
}

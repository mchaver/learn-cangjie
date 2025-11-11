// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

let lesson15Characters = [
  // Introduce 人
  char("人"),
  char("人"),
  char("人"),
  char("人"),
  char("人"),
  // Characters with 人 (A-O available)
  char("个"),
  char("个"),
  char("八"),
  char("八"),
  char("從"),
  char("從"),
  char("入"), // Code correct: OH
  char("入"),
  char("夾"), // Fixed code: KOO not OKO
  char("夾"),
  // Practice mix
  char("人"),
  char("个"),
  char("八"),
  char("從"),
  char("入"),
]

// Lesson 16: 心 - Learn P (心) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P
let lesson16Characters = [
  // Introduce 心
  char("心"),
  char("心"),
  char("心"),
  char("心"),
  char("心"),
  // Characters with 心 (A-P available)
  char("必"),
  char("必"),
  char("必"),
  char("必"),
  // Practice mix (removed 忙 and 忍 - use keys not available)
  char("心"),
  char("必"),
  char("心"),
  char("必"),
  char("心"),
  char("心"),
]

// Lesson 17: 手 - Learn Q (手) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q
let lesson17Characters = [
  // Introduce 手
  char("手"),
  char("手"),
  char("手"),
  char("手"),
  char("手"),
  // Characters with 手 (A-Q available)
  char("拜"), // Fixed code: HQMQJ not QJD
  char("拜"),
  char("打"), // Fixed code: QMN not QJ
  char("打"),
  char("打"),
  char("打"),
  // Practice mix (removed 拾 - uses R not available)
  char("手"),
  char("拜"),
  char("打"),
  char("手"),
  char("打"),
  char("手"),
]

// Lesson 18: 口 - Learn R (口) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R
let lesson18Characters = [
  // Introduce 口
  char("口"),
  char("口"),
  char("口"),
  char("口"),
  char("口"),
  // Characters with 口 (A-R available)
  char("石"),
  char("石"),
  char("呆"),
  char("呆"),
  char("右"),
  char("右"),
  char("扣"),
  char("扣"),
  char("同"),
  char("同"),
  char("古"),
  char("古"), // Fixed: JR not RJR
  char("可"),
  char("可"),
  // Practice mix
  char("口"),
  char("右"),
  char("扣"),
  char("同"),
  char("古"),
]

// CHARACTER SHAPES (字形類) - Lessons 19-24
// Lesson 19: 尸 - Learn S (尸) - Can only use: A-S
let lesson19Characters = [
  // Introduce 尸
  char("尸"),
  char("尸"),
  char("尸"),
  char("尸"),
  char("尸"),
  // Characters with 尸 (A-S available)
  char("尺"),
  char("尺"),
  char("尼"),
  char("尼"),
  char("局"),
  char("局"),
  // Practice mix (removed 尾 - uses U not available)
  char("尸"),
  char("尺"),
  char("尼"),
  char("局"),
]

// Lesson 20: 廿 - Learn T (廿) - Can only use: A-T
let lesson20Characters = [
  // Introduce 廿
  char("廿"),
  char("廿"),
  char("廿"),
  char("廿"),
  char("廿"),
  // Characters with 廿 (A-T available)
  char("卅"),
  char("卅"),
  char("草"),
  char("草"),
  char("若"),
  char("若"),
  char("共"),
  char("共"),
  char("廿"),
  char("廿"),
  // Practice mix
  char("廿"),
  char("卅"),
  char("草"),
  char("若"),
  char("共"),
]

// Lesson 21: 山 - Learn U (山) - Can only use: A-U
let lesson21Characters = [
  // Introduce 山
  char("山"),
  char("山"),
  char("山"),
  char("山"),
  char("山"),
  // Characters with 山 (A-U available)
  char("出"),
  char("出"),
  char("出"),
  char("岐"),
  char("岐"),
  char("屯"),
  char("屯"),
  // Practice mix
  char("山"),
  char("出"),
  char("岐"),
  char("山"),
  char("屯"),
  char("山"),
]

// Lesson 22: 女 - Learn V (女) - Can only use: A-V
let lesson22Characters = [
  // Introduce 女
  char("女"),
  char("女"),
  char("女"),
  char("女"),
  char("女"),
  // Characters with 女 (A-V available)
  char("好"),
  char("好"),
  char("好"),
  char("如"),
  char("如"),
  char("妃"),
  char("妃"),
  // Practice mix
  char("女"),
  char("好"),
  char("如"),
  char("女"),
  char("妃"),
  char("女"),
]

// Lesson 23: 田 - Learn W (田) - Can only use: A-W
let lesson23Characters = [
  // Introduce 田
  char("田"),
  char("田"),
  char("田"),
  char("田"),
  char("田"),
  // Characters with 田 (A-W available)
  char("東"),
  char("東"),
  char("由"),
  char("由"),
  char("甲"),
  char("甲"),
  char("男"),
  char("男"),
  // Practice mix
  char("田"),
  char("東"),
  char("由"),
  char("甲"),
  char("田"),
  char("男"),
]

// Lesson 24: 卜 - Learn Y (卜) - Can only use: A-Y
let lesson24Characters = [
  // Introduce 卜
  char("卜"),
  char("卜"),
  char("卜"),
  char("卜"),
  char("卜"),
  // Characters with 卜 (A-Y available)
  char("上"),
  char("上"),
  char("占"),
  char("占"),
  char("下"),
  char("下"),
  char("外"),
  char("外"),
  char("卡"),
  char("卡"),
  // Practice mix
  char("卜"),
  char("上"),
  char("占"),
  char("下"),
  char("外"),
  char("卡"),
]

// SPECIAL KEYS (特殊鍵) - Lessons 25-26
// Lesson 25: 難 - Learn X (難)
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

let getBodyPartsLessons = (): array<Types.lesson> => {
  let bodyPartsLessons = [
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
        bodyPartsApplicationCharacters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[13, 14], ()),

    // SECTION 4: CHARACTER SHAPES (字形類) - Lessons 17-21
    // Lesson 17: 尸廿
  ]
  bodyPartsLessons
}

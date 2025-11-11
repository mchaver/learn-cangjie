// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

let lesson8Characters = [
  // Introduce 竹
  char("竹"),
  char("竹"),
  char("竹"),
  char("竹"),
  char("竹"),
  // Characters with 竹 (A-H available)
  char("竺"),
  char("竺"),
  char("白"),
  char("白"),
  char("禾"),
  char("禾"),
  char("少"),
  char("少"),
  // Practice mix (removed 皇 - uses M not available yet)
  char("竹"),
  char("白"),
  char("竺"),
  char("禾"),
  char("少"),
  char("竹"),
]

// Lesson 9: 戈 - Learn I (戈) - Can only use: A, B, C, D, E, F, G, H, I
let lesson9Characters = [
  // Introduce 戈
  char("戈"),
  char("戈"),
  char("戈"),
  char("戈"),
  char("戈"),
  // Characters with 戈 (A-I available)
  char("去"),
  char("去"),
  char("公"),
  char("公"),
  char("寸"),
  char("寸"),
  char("戊"), // Fixed code: IH not GI
  char("戊"),
  // Practice mix (removed 戒 - uses T not available)
  char("戈"),
  char("去"),
  char("公"),
  char("戊"),
  char("寸"),
  char("戈"),
]

// Lesson 10: 十 - Learn J (十) - Can only use: A, B, C, D, E, F, G, H, I, J
let lesson10Characters = [
  // Introduce 十
  char("十"),
  char("十"),
  char("十"),
  char("十"),
  char("十"),
  // Characters with 十 (A-J available)
  char("早"),
  char("早"),
  char("末"),
  char("末"),
  char("千"),
  char("千"),
  char("支"),
  char("支"),
  char("成"),
  char("成"),
  // Practice mix (removed 卉 - uses T not available)
  char("十"),
  char("早"),
  char("千"),
  char("成"),
]

// Lesson 11: 大 - Learn K (大) - Can only use: A, B, C, D, E, F, G, H, I, J, K
let lesson11Characters = [
  // Introduce 大
  char("大"),
  char("大"),
  char("大"),
  char("大"),
  char("大"),
  // Characters with 大 (A-K available)
  char("友"),
  char("友"),
  char("灰"),
  char("灰"),
  char("有"),
  char("有"),
  char("太"), // Fixed code: KI not KA
  char("太"),
  // Practice mix (removed 夫 - uses Q,O not available)
  char("大"),
  char("友"),
  char("灰"),
  char("大"),
  char("有"),
  char("太"),
]

// Lesson 12: 中 - Learn L (中) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L
let lesson12Characters = [
  // Introduce 中
  char("中"),
  char("中"),
  char("中"),
  char("中"),
  char("中"),
  // Characters with 中 (A-L available)
  char("申"),
  char("申"),
  char("申"),
  char("串"), // Fixed code: LL not LLL
  char("串"),
  char("央"), // Fixed code: LBK not KLB
  char("央"),
  // Practice mix
  char("中"),
  char("申"),
  char("中"),
  char("串"),
  char("央"),
  char("中"),
]

// Lesson 13: 一 - Learn M (一) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M
let lesson13Characters = [
  // Introduce 一
  char("一"),
  char("一"),
  char("一"),
  char("一"),
  char("一"),
  // Characters with 一 (A-M available)
  char("天"),
  char("天"),
  char("旦"),
  char("旦"),
  char("三"),
  char("三"),
  char("二"),
  char("二"),
  char("工"), // Fixed code: MLM not M
  char("工"),
  // Practice mix
  char("一"),
  char("天"),
  char("旦"),
  char("二"),
  char("三"),
]

// Lesson 14: 弓 - Learn N (弓) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M, N
let lesson14Characters = [
  // Introduce 弓
  char("弓"),
  char("弓"),
  char("弓"),
  char("弓"),
  char("弓"),
  // Characters with 弓 (A-N available)
  char("引"),
  char("引"),
  char("弱"),
  char("弱"),
  char("弔"), // Fixed code: NL not NJB
  char("弔"),
  char("弗"), // Fixed code: LLN not NHE
  char("弗"),
  // Practice mix
  char("弓"),
  char("引"),
  char("弱"),
  char("弔"),
  char("弓"),
]

// BODY PARTS (人體類) - Lessons 15-18
// Lesson 15: 人 - Learn O (人) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M, N, O
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

let getStrokesLessons = (): array<Types.lesson> => {
  let strokesLessons = [
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
        strokesApplicationCharacters
      ),
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[7, 8, 9, 10], ()),

    // SECTION 3: BODY PARTS (人體類) - Lessons 13-16
    // Lesson 13: 人心
  ]
  strokesLessons
}

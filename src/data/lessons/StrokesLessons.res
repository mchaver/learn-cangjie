// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

// Lesson 9: 竹戈
let lesson9Characters = [
  // Part 1
  char("竹"),
  char("竹"),
  char("竹"),
  char("竹"),
  
  char("戈"),
  char("戈"),
  char("戈"),
  char("戈"),

  // Part 1
  char("竹"),
  char("戈"),  
  char("竹"),
  char("戈"),

  char("戈"),
  char("竹"),
  char("戈"),  
  char("竹"),

  // Part 3
  char("白"),
  char("白"),
  char("床"),
  char("床"),

  char("去"),
  char("去"),
  char("公"),
  char("公"),

  // Part 4
  char("禾"),
  char("禾"),
  char("少"),
  char("少"),

  char("寸"),
  char("寸"),
  char("戊"),
  char("戊"),

  // Part 5
  char("戊"),
  char("白"),  
  char("寸"),
  char("禾"),
  
  char("去"),
  char("公"),
  char("床"),
  char("少"),

  // Part 6
  char("去"),  
  char("床"),
  char("白"),
  char("公"),
  
  char("寸"),
  char("少"),  
  char("戊"),
  char("禾"),
]

// char("竺"),

// Lesson 10: 十大
let lesson10Characters = [
  // Part 1
  char("十"),
  char("十"),
  char("十"),
  char("十"),

  char("大"),
  char("大"),
  char("大"),
  char("大"),

  // Part 2
  char("十"),
  char("大"),
  char("十"),
  char("大"),
  char("大"),
  char("十"),
  char("大"),
  char("十"),

  // Part 3
  char("早"),
  char("早"),
  char("末"),
  char("末"),

  char("友"),
  char("友"),
  char("灰"),
  char("灰"),

  // Part 4
  char("千"),
  char("千"),
  char("支"),
  char("支"),

  char("有"),
  char("有"),
  char("太"),
  char("太"),

  // Part 5
  char("丈"),
  char("丈"),
  char("灰"),
  char("千"),

  char("友"),
  char("末"),
  char("早"),
  char("支"),
  
  // Part 6
  char("友"),
  char("末"),
  char("早"),
  char("友"),
  
  char("支"),
  char("有"),
  char("太"),
  char("丈"),
]

// char("成"),

// Lesson 11: Review 竹戈十大
let lesson11Characters = [
  // Part 1
  char("竹"),
  char("戈"),
  char("十"),
  char("大"),

  char("戈"),
  char("大"),
  char("竹"),  
  char("十"),

  // Part 2
  char("大"),
  char("十"),  
  char("戈"),
  char("竹"),  

  char("白"),
  char("床"),
  char("禾"),
  char("少"),

  // Part 3  
  char("去"),
  char("公"),
  char("寸"),
  char("戊"),

  char("千"),
  char("支"),
  char("有"),
  char("太"),

  // Part 4
  char("丈"),
  char("床"),
  char("公"),
  char("白"),

  char("去"),
  char("灰"),
  char("禾"),
  char("千"),

  // Part 5
  char("有"),
  char("禾"),
  char("千"),
  char("支"),

  char("寸"),
  char("灰"),
  char("白"),
  char("床"),
]

// Lesson 12: 中一
let lesson12Characters = [
  // part 1
  char("中"),
  char("中"),
  char("中"),
  char("中"),
  
  char("一"),
  char("一"),
  char("一"),
  char("一"),

  // part 2
  char("中"),
  char("一"),
  char("中"),
  char("一"),

  char("一"),
  char("中"),
  char("一"),
  char("中"),

  // part 3
  char("串"), 
  char("串"),
  char("央"), 
  char("央"),
  
  char("書"),
  char("書"),
  char("原",),
  char("原",),
  
  // part 3 
  char("天"),
  char("天"),
  char("旦"),
  char("旦"),

  char("三"),
  char("三"),
  char("工"),
  char("工"),

  // part 4
  char("原",),
  char("串"),
  char("央"), 
  char("書"),
  
  char("天"),
  char("旦"),
  char("三"),
  char("工"),  
]

// 原
// 十金一 空
//   char("申"),
//  char("申"),


// Lesson 13: 弓
let lesson13Characters = [
  // Part 1
  char("弓"),
  char("弓"),
  char("弓"),
  char("弓"),

  char("竹"),
  char("戈"),
  char("十"),
  char("大"),

  // Part 2
  char("弓"),
  char("中"),
  char("弓"),
  char("一"),

  char("戈"),
  char("弓"),
  char("戈"),
  char("弓"),

  // Part 3
  char("引"),
  char("引"),
  char("弱"),
  char("弱"),

  char("弔"),
  char("弔"),
  char("弗"),
  char("弗"),

  // Part 4
  char("到"),
  char("到"),
  char("弔"),
  char("引"),
  
  char("弱"),
  char("弗"),
  char("到"),
]

// 中一弓
//

// Lesson 14: 一 - Learn M (一) - Can only use: A, B, C, D, E, F, G, H, I, J, K, L, M
let lesson14Characters = [
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

let lesson15Characters = [
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

let getStrokesLessons = (): array<Types.lesson> => {
  let strokesLessons = [
    makeLesson(9, "筆畫 1：竹戈", "學習 H(竹) 和 I(戈)",
      Strokes, Radicals, Practice, [H, I],
      lesson9Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(10, "筆畫 2：十大", "學習 J(十) 和 K(大)",
      Strokes, Radicals, Practice, [J, K],
      lesson10Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(11, "複習竹戈十大", "日月金木複習竹戈十大",    
      Strokes, Radicals, Review, [H, I, J, K],
      lesson11Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(12, "筆畫 3：中一", "學習 中(L) 和 一(M)",
      Strokes, Radicals, Practice, [L, M],
      lesson12Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(13, "筆畫 5：弓", "學習 弓(N)",
      Strokes, Radicals, Practice, [N],
      lesson13Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[], ()),

    // Lesson 12: Comprehensive Review
    // makeLesson(13, "筆畫綜合", "綜合練習筆畫類應用",
    //   Strokes, Radicals, MixedReview, [H, I, J, K, L, M, N],
    //   Js.Array2.concat(
    //     Js.Array2.concat(
    //       Js.Array2.concat(lesson8Characters, lesson9Characters),
    //       Js.Array2.concat(
    //         Js.Array2.concat(lesson10Characters, lesson11Characters),
    //         Js.Array2.concat(
    //           Js.Array2.concat(lesson12Characters, lesson13Characters),
    //           lesson14Characters
    //         )
    //       )
    //     ),
    //     strokesApplicationCharacters
    //   ),
    //   ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[7, 8, 9, 10], ()),
  ]
  strokesLessons
}

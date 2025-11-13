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
  
  // part 4
  char("天"),
  char("天"),
  char("旦"),
  char("旦"),

  char("三"),
  char("三"),
  char("工"),
  char("工"),

  // part 5
  char("原",),
  char("串"),
  char("央"), 
  char("書"),
  
  char("天"),
  char("旦"),
  char("三"),
  char("工"),
]

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
  char("弗"),  
]

// Lesson 14: Review 中一弓
let lesson14Characters = [
  // Part 1
  char("中"),
  char("一"),
  char("弓"),
  char("一"),
  char("弓"),  
  char("中"),
  char("一"),
  char("中"),

  // Part 2
  char("弓"),
  char("一"),
  char("中"),
  char("一"),
  
  char("書"),
  char("原",),
  char("天"),
  char("旦"),

  // Part 3
  char("原"),
  char("串"),
  char("央"), 
  char("書"),
  
  char("天"),
  char("旦"),
  char("三"),
  char("工"),

  // Part 4
  char("央"), 
  char("書"),
  char("弔"),
  char("弱"),
  
  char("引"),
  char("弗"),
  char("到"),
  char("原"),  
]

// Lesson 15: Review 竹戈十大中一弓
let lesson15Characters = [
  // Part 1
  char("竹"),
  char("戈"),
  char("十"),
  char("大"),
  char("中"),  
  char("一"),
  char("弓"),
  char("十"),

  // Part 2
  char("竹"),
  char("戈"),
  char("十"),
  char("大"),
  char("中"),  
  char("一"),
  char("弓"),
  char("十"),

  // Part 3
  char("白"),
  char("少"),
  char("床"),  
  char("天"),

  char("旦"), 
  char("戊"),
  char("公"),
  char("寸"),
  
  // Part 4
  char("去"),
  char("禾"),  
  char("千"),
  char("支"),
  
  char("有"),
  char("太"),
  char("原"),
  char("串"),

  // Part 5
  char("旦"),  
  char("央"), 
  char("書"),
  char("天"),

  char("有"),
  char("旦"),
  char("三"),
  char("工"),

  // Part 6
  char("少"),
  char("床"),  
  char("書"),
  char("天"),

  char("去"),
  char("工"),
  char("戊"),
  char("支"),
]

let generateStrokesTest = (): array<characterInfo> => {
  Array.flat([
    lesson9Characters
  , lesson10Characters
  , lesson12Characters
  , lesson13Characters])
  ->generateTest(48)
}

let generatePhilosophyAndStrokesTest = (): array<characterInfo> => {
  open PhilosophyLessons
  Array.flat([
    lesson1Characters
  , lesson2Characters
  , lesson4Characters
  , lesson5Characters  
  , lesson9Characters
  , lesson10Characters
  , lesson12Characters
  , lesson13Characters])
  ->generateTest(80) 
}

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
      lesson11Characters, ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[9, 10], ()),

    makeLesson(12, "筆畫 3：中一", "學習 中(L) 和 一(M)",
      Strokes, Radicals, Practice, [L, M],
      lesson12Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(13, "筆畫 4：弓", "學習 弓(N)",
      Strokes, Radicals, Practice, [N],
      lesson13Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[], ()),

    makeLesson(14, "複習中一弓", "中一弓",
      Strokes, Radicals, Practice, [N],
      lesson14Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[12, 13], ()),

    makeLesson(15, "筆畫複習", "複習筆畫類所有部首",
      Strokes, Radicals, Review, [H, I, J, K, L, M, N],
      lesson15Characters, ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[9, 10, 12, 13], ()),

    makeLesson(16, "筆畫考試", "綜合練習筆畫複習應用",
      Strokes, Radicals, MixedReview, [H, I, J, K, L, M, N],
      generateStrokesTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[9, 10, 12, 13], ()),

    makeLesson(17, "哲理筆畫考試", "綜合練習哲理和筆畫複習應用",
      Strokes, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N],
      generateStrokesTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 4, 5, 9, 10, 12, 13], ()),
    
  ]
  strokesLessons
}

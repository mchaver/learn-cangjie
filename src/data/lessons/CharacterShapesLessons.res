open Types
open CharacterDictionary

// 尸廿
let lesson23Characters = [
  // Part 1
  char("尸"),
  char("尸"),
  char("尸"),
  char("尸"),

  char("廿"),
  char("廿"),
  char("廿"),
  char("廿"),

  // Part 2
  char("尸"),
  char("廿"),  
  char("尸"),
  char("廿"),

  char("廿"),
  char("尸"),
  char("廿"),  
  char("尸"),

  // Part 3
  char("尺"),
  char("尺"),
  char("尼"),
  char("尼"),
  
  char("局"),
  char("局"),
  char("耳"),
  char("耳"),

  // Part 4
  char("司"),
  char("司"),
  char("草"),
  char("草"),
  
  char("若"),
  char("若"),
  char("共"),
  char("共"),

  // Part 5
  char("甘"),
  char("甘"),
  char("立"),
  char("立"),

  char("局"),
  char("尺"),
  char("尼"),
  char("司"),

  // Part 6
  char("尺"),
  char("甘"),
  char("局"),
  char("若"),
  
  char("尼"),
  char("共"),
  char("耳"),
  char("立"),
  
]

// 山女
let lesson24Characters = [
  // Part 1
  char("山"),
  char("山"),
  char("山"),
  char("山"),

  char("女"),
  char("女"),
  char("女"),
  char("女"),

  // Part 2
  char("山"),
  char("女"),
  char("山"),
  char("女"),

  char("女"),
  char("山"),
  char("女"),
  char("山"),

  // Part 3
  char("出"),
  char("出"),
  char("仙"),
  char("仙"),

  char("目"),
  char("目"),
  char("孔"),
  char("孔"),  

  // Part 4
  char("朔"),
  char("朔"),  
  char("好"),
  char("好"),

  char("如"),
  char("如"),
  char("妃"),
  char("妃"),

  // Part 5
  char("互"),
  char("互"),
  char("表"),
  char("表"),

  char("孔"),
  char("仙"),
  char("目"),
  char("出"),
  
  // Part 6
  char("如"),
  char("互"),
  char("目"),
  char("朔"),  

  char("好"),
  char("朔"),
  char("表"),
  char("妃"),
]

let lesson25Characters = [
  // Part 1
  char("尸"),
  char("女"),
  char("山"),
  char("廿"),

  char("女"),
  char("山"),
  char("廿"),
  char("尸"),
  
  // Part 2
  char("尸"),
  char("山"),
  char("廿"),
  char("女"),

  char("山"),
  char("廿"),
  char("女"),
  char("尸"),

  // Part 3
  char("朔"),  
  char("局"),
  char("甘"),
  char("司"),
  
  char("孔"),
  char("若"),
  char("妃"),
  char("目"),

  // Part 4
  char("耳"),
  char("表"),
  char("尼"),
  char("立"),
  
  char("互"),
  char("仙"),
  char("尺"),
  char("如"),

  // Part 5
  char("共"),
  char("出"),
  char("尼"),
  char("出"),
  
  char("若"),
  char("朔"),  
  char("立"),
  char("孔"),

  // Part 6
  char("仙"),
  char("表"),
  char("局"),
  char("耳"),
  
  char("目"),
  char("甘"),
  char("共"),
  char("司"),

  // Part 7
  char("如"),
  char("妃"),
  char("互"),
  char("尺"),

  char("表"),
  char("局"),
  char("耳"),
  char("孔"),
]

// 田卜
let lesson26Characters = [
  // Part 1
  char("田"),
  char("田"),
  char("田"),
  char("田"),

  char("卜"),
  char("卜"),
  char("卜"),
  char("卜"),

  // Part 2
  char("田"),
  char("卜"),
  char("田"),
  char("卜"),

  char("卜"),
  char("田"),
  char("卜"),
  char("田"),

  // Part 3
  char("東"),
  char("東"),
  char("由"),
  char("由"),
  
  char("甲"),
  char("甲"),
  char("男"),
  char("男"),
  
  // Part 4
  char("上"),
  char("上"),
  char("占"),
  char("占"),
  
  char("下"),
  char("下"),
  char("外"),
  char("外"),

  // Part 5
  char("卡"),
  char("卡"),
  char("巡"),
  char("巡"),  

  char("東"),
  char("由"),
  char("甲"),
  char("男"),

  // Part 6
  char("上"),
  char("占"),
  char("下"),
  char("外"),

  char("卡"),
  char("巡"),
  char("東"),
  char("外"),
]

let lesson27Characters = [
  // Part 1
  char("卜"),
  char("田"),
  char("卜"),
  char("田"),
  char("田"),
  char("卜"),
  char("田"),
  char("卜"),

  // Part 2
  char("甲"),
  char("外"),
  char("東"),
  char("東"),
  
  char("上"),
  char("男"),
  char("卡"),
  char("下"),

  // Part 3
  char("由"),
  char("巡"),
  char("占"),
  char("外"),

  char("東"),
  char("占"),
  char("男"),
  char("下"),

  // Part 4
  char("外"),
  char("巡"),
  char("外"),
  char("卡"),
  
  char("由"),
  char("上"),
  char("甲"),
  char("東"),
]

let generateCharacterShapesTest = (): array<characterInfo> => {
  Array.flat([
    lesson23Characters
  , lesson24Characters
  , lesson26Characters])
  ->generateTest(48)
}

let generatePhilosophyStrokesBodyPartsAndCharacterShapesTest = (): array<characterInfo> => {
  open PhilosophyLessons
  open StrokesLessons
  open BodyPartsLessons  
  Array.flat([
    lesson1Characters
  , lesson2Characters
  , lesson4Characters
  , lesson5Characters  
  , lesson9Characters
  , lesson10Characters
  , lesson12Characters
  , lesson13Characters
  , lesson18Characters
  , lesson19Characters
  , lesson23Characters
  , lesson24Characters
  , lesson26Characters])
  ->generateTest(120)
}

let getCharacterShapesLessons = (): array<Types.lesson> => {
  [
    makeLesson(23, "字形 1：尸廿", "學習 S(尸) 和 T(廿)",
      CharacterShapes, Radicals, Practice, [S, T],
      lesson23Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(24, "字形 2：山女", "學習 U(山) 和 V(女)",
      CharacterShapes, Radicals, Practice, [U, V],
      lesson24Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(25, "字形複習", "複習字形類所有部首",
      CharacterShapes, Radicals, Review, [S, T, U, V],
      lesson25Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[23, 24], ()),

    makeLesson(26, "字形 3：田卜", "學習 W(田) 和 Y(卜)",
      CharacterShapes, Radicals, Practice, [W, Y],
      lesson26Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(27, "字形複習", "複習字形類所有部首",
      CharacterShapes, Radicals, Review, [W, Y],
      lesson27Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[26], ()),

    makeLesson(28, "字形考試", "綜合練習人體習應用",
      CharacterShapes, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, Y],
      generateCharacterShapesTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[23, 24, 26], ()),

    makeLesson(29, "哲理筆畫人體字形考試", "綜合練習哲理筆畫和人體複習應用",
      CharacterShapes, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, Y],
      generatePhilosophyStrokesBodyPartsAndCharacterShapesTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 4, 5, 9, 10, 12, 13, 18, 19, 23, 24, 26], ()),
  ]
}

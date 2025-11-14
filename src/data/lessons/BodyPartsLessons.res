// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

// 人心
let lesson18Characters = [
  // Part 1
  char("人"),
  char("人"),
  char("人"),
  char("人"),

  char("心"),
  char("心"),
  char("心"),
  char("心"),

  // Part 2
  char("人"),
  char("心"),
  char("人"),
  char("心"),

  char("心"),
  char("人"),
  char("心"),
  char("人"),

  // Part 3
  char("个"),
  char("个"),
  char("必"),
  char("必"),
  
  char("八"),
  char("八"),
  char("怕"),
  char("怕"),

  // Part 4
  char("從"),
  char("從"),
  char("老"),
  char("老"),

  char("入"),
  char("入"),
  char("代"),
  char("代"),

  // Part 5
  char("夾"),
  char("夾"),
  char("老"),
  char("入"),

  char("從"),
  char("必"),
  char("八"),
  char("怕"),

  // Part 6
  char("從"),
  char("老"),
  char("入"),
  char("代"),
  
  char("夾"),
  char("必"),
  char("个"),
  char("老"),
]

// 手口
let lesson19Characters = [
  // Part 1
  char("手"),
  char("手"),
  char("手"),
  char("手"),

  char("口"),
  char("口"),
  char("口"),
  char("口"),

  // Part 2
  char("手"),
  char("口"),  
  char("手"),
  char("口"),

  char("口"),
  char("手"),
  char("口"),  
  char("手"),

  // Part 3
  char("打"),
  char("打"),  
  char("拜"),
  char("拜"),

  char("石"),
  char("石"),
  char("同"),
  char("同"),

  // Part 4
  char("承"),
  char("承"),
  char("年"),
  char("年"),

  char("拿"),
  char("拿"),
  char("右"),
  char("右"),

  // Part 5
  char("可"),
  char("可"),  
  char("古"),
  char("古"),

  char("拿"),
  char("右"),
  char("承"),
  char("年"),

  // Part 6
  char("拜"),
  char("同"),
  char("打"),  
  char("石"),

  char("可"),  
  char("古"),
  char("拿"),
  char("承"),
]

// Review
let lesson20Characters = [
  // Part 1
  char("手"),
  char("人"),
  char("口"),
  char("心"),

  char("人"),
  char("心"),
  char("口"),
  char("手"),

  // Part 2
  char("人"),
  char("心"),
  char("口"),
  char("手"),
  
  char("心"),
  char("人"),
  char("手"),  
  char("口"),

  // Part 3
  char("石"),
  char("打"),  
  char("從"),
  char("同"),
  
  char("个"),
  char("拿"),
  char("八"),
  char("必"),

  // Part 4
  char("夾"),
  char("古"),
  char("怕"),
  char("可"),

  char("代"),
  char("老"),
  char("拜"),
  char("年"),

  // Part 5
  char("右"),
  char("入"),
  char("承"),
  char("代"),
  
  char("必"),
  char("老"),
  char("同"),
  char("可"),

  // Part 6
  char("古"),
  char("拿"),
  char("夾"),
  char("年"),
  
  char("八"),
  char("承"),
  char("石"),
  char("從"),

  // Part 7
  char("打"),  
  char("承"),
  char("怕"),
  char("右"),
  
  char("个"),
  char("入"),
  char("入"),
  char("拜"),  
]

let generateBodyPartsTest = (): array<characterInfo> => {
  Array.flat([
    lesson19Characters
  , lesson20Characters])
  ->generateTest(48)
}

let generatePhilosophyStrokesAndBodyPartsTest = (): array<characterInfo> => {
  open PhilosophyLessons
  open StrokesLessons
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
  , lesson19Characters])
  ->generateTest(104) 
}


let getBodyPartsLessons = (): array<Types.lesson> => {
  [
    makeLesson(18, "人體 1：人心", "學習 O(人) 和 P(心)",
      BodyParts, Radicals, Practice, [O, P],
      lesson18Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(19, "人體 2：手口", "學習 Q(手) 和 R(口)",
      BodyParts, Radicals, Practice, [Q, R],
      lesson19Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(20, "人體複習", "複習人體類所有部首",
      BodyParts, Radicals, Review, [O, P, Q, R],
      lesson20Characters,
      ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[16, 17], ()),

    makeLesson(21, "人體考試", "綜合練習人體習應用",
      BodyParts, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R],
      generateBodyPartsTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[18, 19], ()),

    makeLesson(22, "哲理筆畫人體考試", "綜合練習哲理筆畫和人體複習應用",
      BodyParts, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R],
      generatePhilosophyStrokesAndBodyPartsTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 4, 5, 9, 10, 12, 13, 18, 19], ()),
  ]
}

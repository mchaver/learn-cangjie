open Types
open CharacterDictionary

let lesson30Characters = [
    // Part 1
    char("臼"),
    char("臼"),    
    char("與"),
    char("與"),    

    char("興"),
    char("興"),    
    char("盥"),
    char("盥"),

    // Part 2
    char("姊"),
    char("姊"),    
    char("齊"),
    char("齊"),
    
    char("兼"),
    char("兼"),    
    char("鹿"),
    char("鹿"),

    // Part 3
    char("身"),
    char("身"),    
    char("卍"),
    char("卍"),
    
    char("黽"),
    char("黽"),    
    char("龜"),
    char("龜"),

    // Part 4
    char("廌"),
    char("廌"),
    char("慶"),
    char("慶"),
    
    char("淵"),
    char("淵"),
    char("肅"),
    char("肅"),

    // Part 5
    char("慶"),
    char("兼"),
    char("臼"),
    char("興"),
    
    char("身"),
    char("卍"),    
    char("盥"),
    char("齊"),

    // Part 6
    char("黽"),
    char("肅"),
    char("廌"),
    char("姊"),
    
    char("鹿"),
    char("與"),
    char("淵"),
    char("龜"),

    // Part 7
    char("身"),
    char("慶"),
    char("黽"),
    char("龜"),

    char("卍"),    
    char("齊"),    
    char("姊"),
    char("臼"),

    // Part 8
    char("鹿"),
    char("淵"),
    char("廌"),
    char("盥"),
    
    char("與"),
    char("肅"),
    char("兼"),
    char("興"),    
]

let generateAllRadicalsTest = (): array<characterInfo> => {
  open PhilosophyLessons
  open StrokesLessons
  open BodyPartsLessons
  open CharacterShapesLessons
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
  , lesson26Characters
  , lesson30Characters])
  ->generateTest(160)
}

let getDifficultCharactersLessons = (): array<Types.lesson> => {
  [
    makeLesson(30, "難字", "學習 X(難)",
      SpecialKeys, Radicals, Practice, [X],
      lesson30Characters, ~showCode=false, ~allowHints=true, ()),

    makeLesson(31, "字根考試", "字根考試",
      SpecialKeys, Radicals, MixedReview, [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, Y, X],
      generateAllRadicalsTest(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 4, 5, 9, 10, 12, 13, 18, 19, 23, 24, 26, 30], ()),
  ]
}

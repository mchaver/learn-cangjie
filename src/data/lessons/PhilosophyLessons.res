// Expanded Cangjie lesson data with words, phrases, chengyu, and sentences
// This module generates lessons dynamically and includes much more content

open Types
open CharacterDictionary

// Lesson 1: 日月
let lesson1Characters = [
  // part 1
  // Introduce 日
  char("日"),
  char("日"),
  char("日"),
  char("日"),
  // Introduce 月
  char("月"),
  char("月"),
  char("月"),
  char("月"),

  // part2
  char("日"),
  char("月"),
  char("日"),
  char("月"),
  char("月"),
  char("日"),
  char("月"),
  char("日"),

  // part3
  // Introduce 昌
  char("昌"),
  char("昌"),
  char("昌"),
  char("昌"),
  // Introduce 朋
  char("朋"),
  char("朋"),
  char("朋"),
  char("朋"),

  // part4
  // Introduce 明
  char("明"),
  char("明"),
  char("昌"),
  char("朋"),

  // Introduce 㸓
  char("㸓"),
  char("㸓"),
  char("昌"),
  char("明"),
  
  // part 5
  char("月"),
  char("日"),
  char("明"),
  char("㸓"),  
  char("朋"),  
  char("㸓"),
  char("明"),
  char("昌"),
]

// Lesson 2: 金木
let lesson2Characters = [
  // part 1
  // Introduce 金
  char("金"),
  char("金"),
  char("金"),
  char("金"),
  // Introduce 木
  char("木"),
  char("木"),
  char("木"),
  char("木"),

  // part 2
  char("金"),
  char("木"),
  char("金"),
  char("木"),
  char("木"),  
  char("金"),
  char("木"),  
  char("金"),

  // part 3
  char("鈤"),
  char("鈤"),
  char("林"),
  char("林"),

  char("鈅"),
  char("鈅") , 
  char("森"),
  char("森"),

  // part 4  
  char("杲"),
  char("杲"),  
  char("杳"),
  char("杳"),  

  char("采"),
  char("采"),   
  char("朿"),
  char("朿"),   

  // part 5
  char("釟"),
  char("釟"),  
  char("朳"),
  char("朳"),

  char("㓁"),
  char("㓁"),
  char("鈅") , 
  char("森"),

  // part 6
  char("明"),
  char("朋"),  
  char("㸓"),
  char("昌"),

  char("釟"),
  char("朳"),
  char("㓁"),
  char("森"),
]

// Lesson 3: Review 日月金木
let lesson3Characters = [
  // part 1
  char("日"),
  char("月"),
  char("金"),
  char("木"),
  char("月"),
  char("金"),
  char("木"),
  char("日"),

  // part 2
  char("金"),
  char("日"),
  char("木"),
  char("月"),

  char("明"),
  char("朋"),  
  char("昌"),
  char("㸓"),

  // part 3
  char("昌"),
  char("朋"),
  char("明"),
  char("林"),

  char("朳"),  
  char("釟"),
  char("森"),
  char("采"),
  
  // part4
  char("㓁"),
  char("鈅"),
  char("㓁"),
  char("杲"),

  char("朿"),
  char("㸓"),
  char("杳"),
  char("采"),
]

// Lesson 4: 水火
let lesson4Characters = [
  // Part 1
  // Introduce 水
  char("水"),
  char("水"),
  char("水"),
  char("水"),
  // Introduce 火
  char("火"),
  char("火"),
  char("火"),
  char("火"),

  // Part 2
  char("水"),
  char("火"),
  char("水"),
  char("火"),
  char("火"),
  char("水"),
  char("火"),
  char("水"),  

  // Part 3
  char("汉"),
  char("汉"),
  char("炎"),
  char("炎"),

  char("肖"),
  char("肖"),
  char("脊"),
  char("脊"),

  // Part 4
  char("沐"),
  char("沐"),
  char("消"),
  char("消"),

  char("汉"),
  char("炎"),
  char("肖"),
  char("脊"),
]

// Lesson 5: 土 - Learn G (土)
let lesson5Characters = [
  // Part 1
  char("土"),
  char("土"),
  char("土"),
  char("土"),

  char("火"),
  char("水"),
  char("日"),
  char("月"),

  // Part 2
  char("土"),
  char("金"),  
  char("土"),
  char("火"),
  char("木"),  
  char("土"),
  char("水"),
  char("土"),

  // Part 3
  char("灶"),
  char("灶"),
  char("圣"),
  char("圣"),
  char("桂"),
  char("桂"),
  char("肚"),
  char("肚"),

  // Part 4
  char("金"),
  char("肚"),
  char("土"),
  char("灶"),  
  char("火"),
  char("桂"),
  char("圣"),
  char("月"),
]

// Lesson 6: Review 日月金木水火土
let lesson6Characters = [
  // Part 1
  char("土"),
  char("火"),
  char("水"),
  char("日"),
  char("月"),
  char("土"),
  char("火"),
  char("木"),

  // Part 2
  char("日"),
  char("火"),
  char("月"),
  char("土"),
  char("水"),
  char("火"),
  char("木"),
  char("水"),

  // Part 3
  char("肚"),
  char("灶"),
  char("桂"),
  char("圣"),

  char("森"),
  char("朳"),
  char("釟"),
  char("林"),

  // part 4
  char("鈅"),
  char("㓁"),
  char("杲"),
  char("杳"),

  char("采"),
  char("朿"),
  char("㓁"),
  char("釟"),

  // part 5
  char("㸓"),
  char("㓁"),
  char("朿"),
  char("采"),

  char("沐"),
  char("消"),
  char("汉"),
  char("炎"),

  // part 6
  char("肖"),
  char("脊"),
  char("肚"),
  char("灶"),

  char("㓁"),
  char("采"),
  char("朿"),
  char("圣"),
]

// Generate dynamic lesson 7 characters with weighted randomization
// Collects unique characters from lessons 1-5, weights by code complexity
let generateLesson7Characters = (): array<characterInfo> => {
  // Collect all characters from lessons 1-5
  let allSourceChars =
    lesson1Characters
    ->Array.concat(lesson2Characters)
    ->Array.concat(lesson3Characters)
    ->Array.concat(lesson4Characters)
    ->Array.concat(lesson5Characters)

  // Get unique characters by using character string as key
  let uniqueCharsMap = Belt.Map.String.empty
  let uniqueCharsMap = allSourceChars->Array.reduce(uniqueCharsMap, (acc, charInfo) => {
    acc->Belt.Map.String.set(charInfo.character, charInfo)
  })

  let uniqueChars = uniqueCharsMap->Belt.Map.String.valuesToArray

  // Build weighted pool: 1-key = weight 1, 2+ keys = weight 2
  let weightedPool = uniqueChars->Array.flatMap(charInfo => {
    let codeLength = charInfo.cangjieCode->Array.length
    if codeLength == 1 {
      [charInfo] // Add once for 1-key characters
    } else {
      [charInfo, charInfo] // Add twice for 2+ key characters
    }
  })

  // Shuffle and take 48
  let shuffled = CangjieUtils.shuffleArray(weightedPool)
  shuffled->Array.slice(~start=0, ~end=48)
}

let getPhilosophyLessons = (): array<Types.lesson> => {
  [
    makeLesson(1, "哲理 1：日月", "學習 A(日) 和 B(月)",
      Philosophy, Radicals, Practice, [A, B],
      lesson1Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 2: 金木
    makeLesson(2, "哲理 2：金木", "學習 C(金) 和 D(木)",
      Philosophy, Radicals, Practice, [C, D],
      lesson2Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 3: 複習日月金木
    makeLesson(3, "複習日月金木", "日月金木",
      Philosophy, Radicals, Review, [A, B, C, D],
      lesson3Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 4: 水火
    makeLesson(4, "哲理 3：水火", "學習 E(水) 和 F(火)",
      Philosophy, Radicals, Practice, [E, F],
      lesson4Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 5: 土
    makeLesson(5, "哲理 4：土", "學習 G(土)",
      Philosophy, Radicals, Practice, [G],
      lesson5Characters, ~showCode=false, ~allowHints=true, ()),

    // Lesson 6: Review
    // 水火土
    
    // Lesson 6: Review
    // 日月金木水火土
    makeLesson(6, "哲理複習", "複習哲理類所有部首",
      Philosophy, Radicals, Review, [A, B, C, D, E, F, G],
      lesson6Characters, ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 4, 5], ()),

    // test
    // Lesson 7: Comprehensive Review (Dynamic - regenerated each time)
    makeLesson(7, "哲理綜合", "綜合練習哲理類應用",
      Philosophy, Radicals, MixedReview, [A, B, C, D, E, F, G],
      generateLesson7Characters(), ~showCode=false, ~allowHints=false, ~allowGiveUp=true, ~reviewsLessons=[1, 2, 3, 4, 5], ()),
  ]
}

// Main Cangjie Data module - combines all lesson sections
// This module re-exports the character dictionary and all lessons

open Types

// Re-export the character dictionary and helper function
include CharacterDictionary

// Import all lesson sections
module Philosophy = PhilosophyLessons
module Strokes = StrokesLessons
module BodyParts = BodyPartsLessons
module CharacterShapes = CharacterShapesLessons
module Advanced = AdvancedLessons

// Combine all lessons into a single array
let getAllLessons = (): array<lesson> => {
  Js.Array2.concat(
    Philosophy.getPhilosophyLessons(),
    Js.Array2.concat(
      Strokes.getStrokesLessons(),
      Js.Array2.concat(
        BodyParts.getBodyPartsLessons(),
        Js.Array2.concat(
          CharacterShapes.getCharacterShapesLessons(),
          Advanced.getAdvancedLessons()
        )
      )
    )
  )
}

let allLessons = getAllLessons()

// Cache for lesson 7 - regenerated once per visit
let lesson7Cache: ref<option<lesson>> = ref(None)

// Clear the lesson 7 cache to trigger regeneration on next access
let clearLesson7Cache = () => {
  lesson7Cache := None
}

// Get lesson by ID
// Special case: Lesson 7 is cached per visit and regenerated only when cache is cleared
let getLessonById = (id: int): option<lesson> => {
  if id == 7 {
    switch lesson7Cache.contents {
    | Some(cachedLesson) => Some(cachedLesson)
    | None => {
        // Generate fresh lesson 7
        let lessons = Philosophy.getPhilosophyLessons()
        let lesson7 = lessons->Js.Array2.find(lesson => lesson.id == 7)
        // Cache it
        lesson7Cache := lesson7
        lesson7
      }
    }
  } else {
    allLessons->Js.Array2.find(lesson => lesson.id == id)
  }
}

// Get next lesson after completing one
let getNextLesson = (currentId: int): option<lesson> => {
  allLessons->Js.Array2.find(lesson => lesson.id == currentId + 1)
}

// Get placement test
let getPlacementTest = (): option<lesson> => {
  getLessonById(100)
}

// Create a randomized review lesson from completed lessons
let createReviewLesson = (completedLessonIds: array<int>, characterCount: int): option<lesson> => {
  // Collect all characters from completed lessons
  let allChars = completedLessonIds
    ->Js.Array2.map(id => getLessonById(id))
    ->Js.Array2.filter(Belt.Option.isSome)
    ->Js.Array2.map(Belt.Option.getExn)
    ->Js.Array2.reduce((acc, lesson) => {
      Js.Array2.concat(acc, lesson.characters)
    }, [])

  if allChars->Js.Array2.length == 0 {
    None
  } else {
    // Shuffle and take requested number of characters
    let shuffled = CangjieUtils.shuffleArray(allChars)
    let selected = shuffled->Js.Array2.slice(~start=0, ~end_=Js.Math.min_int(characterCount, shuffled->Js.Array2.length))

    Some({
      id: 9000, // Special ID for review lessons
      title: "隨機複習",
      description: `複習 ${Belt.Int.toString(selected->Js.Array2.length)} 個已學過的字`,
      section: Advanced,
      category: Custom,
      lessonType: Review,
      introducedKeys: [],
      characters: selected,
      targetAccuracy: 0.85,
      targetSpeed: Some(25.0),
      showCode: false,
      allowHints: false,
      allowGiveUp: true,
      reviewsLessons: completedLessonIds,
    })
  }
}

// Create a timed challenge lesson
let createTimedChallenge = (completedLessonIds: array<int>, durationSeconds: int): option<lesson> => {
  // Collect all characters from completed lessons
  let allChars = completedLessonIds
    ->Js.Array2.map(id => getLessonById(id))
    ->Js.Array2.filter(Belt.Option.isSome)
    ->Js.Array2.map(Belt.Option.getExn)
    ->Js.Array2.reduce((acc, lesson) => {
      Js.Array2.concat(acc, lesson.characters)
    }, [])

  if allChars->Js.Array2.length == 0 {
    None
  } else {
    // Create a large pool of characters (shuffle and repeat)
    let poolSize = 100

    // Repeat characters to create a larger pool
    let rec buildPool = (pool: array<characterInfo>, remaining: int): array<characterInfo> => {
      if remaining <= 0 {
        pool
      } else {
        let newChars = CangjieUtils.shuffleArray(allChars)
        let needed = Js.Math.min_int(remaining, newChars->Js.Array2.length)
        let toAdd = newChars->Js.Array2.slice(~start=0, ~end_=needed)
        buildPool(Js.Array2.concat(pool, toAdd), remaining - needed)
      }
    }

    let challengeChars = buildPool([], poolSize)

    Some({
      id: 9001, // Special ID for timed challenges
      title: `限時挑戰 (${Belt.Int.toString(durationSeconds)}秒)`,
      description: `在 ${Belt.Int.toString(durationSeconds)} 秒內盡可能打出更多字`,
      section: Advanced,
      category: Custom,
      lessonType: TimedChallenge,
      introducedKeys: [],
      characters: challengeChars,
      targetAccuracy: 0.80,
      targetSpeed: Some(30.0),
      showCode: false,
      allowHints: false,
      allowGiveUp: false,
      reviewsLessons: [],
    })
  }
}

// Build a map from character to its earliest lesson ID (for multi-character codes only)
// This is used for the "EarliestLesson" practice repeat mode setting
let getCharacterEarliestLessonMap = (): Belt.Map.String.t<int> => {
  // Start with empty map
  let map = ref(Belt.Map.String.empty)

  // Iterate through all lessons in order (lowest ID first)
  allLessons->Js.Array2.forEach(lesson => {
    // For each character in the lesson
    lesson.characters->Js.Array2.forEach(charInfo => {
      // Only track multi-character codes (2+ keys)
      let isMultiChar = charInfo.cangjieCode->Js.Array2.length > 1
      if isMultiChar {
        // Only set if this character hasn't been seen before
        // (since we iterate lessons in order, first occurrence is earliest)
        switch map.contents->Belt.Map.String.get(charInfo.character) {
        | None => map := map.contents->Belt.Map.String.set(charInfo.character, lesson.id)
        | Some(_) => () // Already have an earlier lesson for this character
        }
      }
    })
  })

  map.contents
}

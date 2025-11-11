// LocalStorage utilities for persisting user progress

open Types

// External bindings for localStorage
@val @scope("localStorage") external getItem: string => Js.Nullable.t<string> = "getItem"
@val @scope("localStorage") external setItem: (string, string) => unit = "setItem"

let storageKey = "cangjie_user_progress"

// Default user progress
let defaultProgress: userProgress = {
  completedLessons: [],
  lessonProgress: [],
  currentLesson: 1,
  placementTestTaken: false,
  placementResult: None,
}

// Encode placement result to JSON
let encodePlacementResult = (result: option<placementResult>): Js.Json.t => {
  switch result {
  | None => Js.Json.null
  | Some(r) =>
    Js.Dict.fromArray([
      ("accuracy", Js.Json.number(r.accuracy)),
      ("speed", Js.Json.number(r.speed)),
      ("recommendedLessonId", Js.Json.number(float_of_int(r.recommendedLessonId))),
      ("date", Js.Json.number(r.date->Js.Date.getTime)),
    ])->Js.Json.object_
  }
}

// Encode user progress to JSON
let encodeProgress = (progress: userProgress): Js.Json.t => {
  Js.Dict.fromArray([
    ("completedLessons", Js.Json.numberArray(progress.completedLessons->Js.Array2.map(float_of_int))),
    ("currentLesson", Js.Json.number(float_of_int(progress.currentLesson))),
    ("placementTestTaken", Js.Json.boolean(progress.placementTestTaken)),
    ("placementResult", encodePlacementResult(progress.placementResult)),
    ("lessonProgress", Js.Json.array(progress.lessonProgress->Js.Array2.map(lp => {
      Js.Dict.fromArray([
        ("lessonId", Js.Json.number(float_of_int(lp.lessonId))),
        ("completed", Js.Json.boolean(lp.completed)),
        ("bestAccuracy", Js.Json.number(lp.bestAccuracy)),
        ("bestSpeed", Js.Json.number(lp.bestSpeed)),
        ("attemptCount", Js.Json.number(float_of_int(lp.attemptCount))),
      ])->Js.Json.object_
    }))),
  ])->Js.Json.object_
}

// Decode lesson progress from JSON
let decodeLessonProgress = (json: Js.Json.t): option<lessonProgress> => {
  json->Js.Json.decodeObject->Belt.Option.flatMap(dict => {
    let lessonId = dict->Js.Dict.get("lessonId")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
    let completed = dict->Js.Dict.get("completed")->Belt.Option.flatMap(Js.Json.decodeBoolean)
    let bestAccuracy = dict->Js.Dict.get("bestAccuracy")->Belt.Option.flatMap(Js.Json.decodeNumber)
    let bestSpeed = dict->Js.Dict.get("bestSpeed")->Belt.Option.flatMap(Js.Json.decodeNumber)
    let attemptCount = dict->Js.Dict.get("attemptCount")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)

    switch (lessonId, completed, bestAccuracy, bestSpeed, attemptCount) {
    | (Some(lid), Some(c), Some(ba), Some(bs), Some(ac)) =>
      Some({
        lessonId: lid,
        completed: c,
        bestAccuracy: ba,
        bestSpeed: bs,
        attemptCount: ac,
        lastAttemptDate: None,
      })
    | _ => None
    }
  })
}

// Decode placement result from JSON
let decodePlacementResult = (json: Js.Json.t): option<placementResult> => {
  json->Js.Json.decodeObject->Belt.Option.flatMap(dict => {
    let accuracy = dict->Js.Dict.get("accuracy")->Belt.Option.flatMap(Js.Json.decodeNumber)
    let speed = dict->Js.Dict.get("speed")->Belt.Option.flatMap(Js.Json.decodeNumber)
    let recommendedLessonId = dict->Js.Dict.get("recommendedLessonId")
      ->Belt.Option.flatMap(Js.Json.decodeNumber)
      ->Belt.Option.map(int_of_float)
    let date = dict->Js.Dict.get("date")
      ->Belt.Option.flatMap(Js.Json.decodeNumber)
      ->Belt.Option.map(t => Js.Date.fromFloat(t))

    switch (accuracy, speed, recommendedLessonId, date) {
    | (Some(a), Some(s), Some(r), Some(d)) =>
      Some({
        accuracy: a,
        speed: s,
        recommendedLessonId: r,
        date: d,
      })
    | _ => None
    }
  })
}

// Decode user progress from JSON
let decodeProgress = (json: Js.Json.t): option<userProgress> => {
  json->Js.Json.decodeObject->Belt.Option.flatMap(dict => {
    let completedLessons = dict->Js.Dict.get("completedLessons")
      ->Belt.Option.flatMap(Js.Json.decodeArray)
      ->Belt.Option.map(arr => arr->Js.Array2.map(v =>
        v->Js.Json.decodeNumber->Belt.Option.map(int_of_float)->Belt.Option.getWithDefault(0)
      ))

    let currentLesson = dict->Js.Dict.get("currentLesson")
      ->Belt.Option.flatMap(Js.Json.decodeNumber)
      ->Belt.Option.map(int_of_float)

    let placementTestTaken = dict->Js.Dict.get("placementTestTaken")
      ->Belt.Option.flatMap(Js.Json.decodeBoolean)

    let placementResult = dict->Js.Dict.get("placementResult")
      ->Belt.Option.flatMap(v =>
        switch Js.Json.classify(v) {
        | Js.Json.JSONNull => Some(None)
        | _ => decodePlacementResult(v)->Belt.Option.map(r => Some(r))
        }
      )
      ->Belt.Option.getWithDefault(None)

    let lessonProgress = dict->Js.Dict.get("lessonProgress")
      ->Belt.Option.flatMap(Js.Json.decodeArray)
      ->Belt.Option.map(arr =>
        arr->Js.Array2.map(decodeLessonProgress)
           ->Js.Array2.filter(Belt.Option.isSome)
           ->Js.Array2.map(Belt.Option.getExn)
      )

    switch (completedLessons, currentLesson, placementTestTaken, lessonProgress) {
    | (Some(cl), Some(curr), Some(pt), Some(lp)) =>
      Some({
        completedLessons: cl,
        lessonProgress: lp,
        currentLesson: curr,
        placementTestTaken: pt,
        placementResult: placementResult,
      })
    | _ => None
    }
  })
}

// Load progress from localStorage
let loadProgress = (): userProgress => {
  switch getItem(storageKey)->Js.Nullable.toOption {
  | None => defaultProgress
  | Some(str) =>
    try {
      let json = Js.Json.parseExn(str)
      decodeProgress(json)->Belt.Option.getWithDefault(defaultProgress)
    } catch {
    | _ => defaultProgress
    }
  }
}

// Save progress to localStorage
let saveProgress = (progress: userProgress): unit => {
  let json = encodeProgress(progress)
  let str = Js.Json.stringify(json)
  setItem(storageKey, str)
}

// Update lesson progress
let updateLessonProgress = (
  progress: userProgress,
  lessonId: int,
  accuracy: float,
  speed: float,
  completed: bool,
): userProgress => {
  let existingProgress = progress.lessonProgress->Js.Array2.find(lp => lp.lessonId == lessonId)

  let newLessonProgress = switch existingProgress {
  | Some(lp) => {
      lessonId: lessonId,
      completed: completed || lp.completed,
      bestAccuracy: Js.Math.max_float(accuracy, lp.bestAccuracy),
      bestSpeed: Js.Math.max_float(speed, lp.bestSpeed),
      attemptCount: lp.attemptCount + 1,
      lastAttemptDate: Some(Js.Date.make()),
    }
  | None => {
      lessonId: lessonId,
      completed: completed,
      bestAccuracy: accuracy,
      bestSpeed: speed,
      attemptCount: 1,
      lastAttemptDate: Some(Js.Date.make()),
    }
  }

  let updatedLessonProgress = progress.lessonProgress
    ->Js.Array2.filter(lp => lp.lessonId != lessonId)
    ->Js.Array2.concat([newLessonProgress])

  let updatedCompletedLessons = if completed && !(progress.completedLessons->Js.Array2.includes(lessonId)) {
    progress.completedLessons->Js.Array2.concat([lessonId])
  } else {
    progress.completedLessons
  }

  {
    ...progress,
    lessonProgress: updatedLessonProgress,
    completedLessons: updatedCompletedLessons,
  }
}

// Get progress for a specific lesson
let getLessonProgress = (progress: userProgress, lessonId: int): option<lessonProgress> => {
  progress.lessonProgress->Js.Array2.find(lp => lp.lessonId == lessonId)
}

// Temporary storage for completion stats
let completionStatsKey = "cangjie_completion_stats"

// Save completion stats temporarily for the completion screen
let saveCompletionStats = (lessonId: int, inputState: inputState): unit => {
  let json = Js.Dict.fromArray([
    ("lessonId", Js.Json.number(float_of_int(lessonId))),
    ("currentIndex", Js.Json.number(float_of_int(inputState.currentIndex))),
    ("currentInput", Js.Json.string(inputState.currentInput)),
    ("totalCharacters", Js.Json.number(float_of_int(inputState.stats.totalCharacters))),
    ("correctCharacters", Js.Json.number(float_of_int(inputState.stats.correctCharacters))),
    ("incorrectCharacters", Js.Json.number(float_of_int(inputState.stats.incorrectCharacters))),
    ("startTime", Js.Json.number(inputState.stats.startTime)),
    ("errors", Js.Json.array(inputState.errors->Js.Array2.map(((idx, input)) => {
      Js.Dict.fromArray([
        ("index", Js.Json.number(float_of_int(idx))),
        ("input", Js.Json.string(input)),
      ])->Js.Json.object_
    }))),
  ])->Js.Json.object_

  setItem(completionStatsKey, Js.Json.stringify(json))
}

// Load completion stats from temporary storage
let loadCompletionStats = (): option<(int, inputState)> => {
  switch getItem(completionStatsKey)->Js.Nullable.toOption {
  | None => None
  | Some(str) =>
    try {
      let json = Js.Json.parseExn(str)
      json->Js.Json.decodeObject->Belt.Option.flatMap(dict => {
        let lessonId = dict->Js.Dict.get("lessonId")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
        let currentIndex = dict->Js.Dict.get("currentIndex")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
        let currentInput = dict->Js.Dict.get("currentInput")->Belt.Option.flatMap(Js.Json.decodeString)
        let totalCharacters = dict->Js.Dict.get("totalCharacters")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
        let correctCharacters = dict->Js.Dict.get("correctCharacters")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
        let incorrectCharacters = dict->Js.Dict.get("incorrectCharacters")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
        let startTime = dict->Js.Dict.get("startTime")->Belt.Option.flatMap(Js.Json.decodeNumber)
        let errors = dict->Js.Dict.get("errors")->Belt.Option.flatMap(Js.Json.decodeArray)->Belt.Option.map(arr =>
          arr->Js.Array2.map(e => {
            e->Js.Json.decodeObject->Belt.Option.flatMap(d => {
              let idx = d->Js.Dict.get("index")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
              let input = d->Js.Dict.get("input")->Belt.Option.flatMap(Js.Json.decodeString)
              switch (idx, input) {
              | (Some(i), Some(inp)) => Some((i, inp))
              | _ => None
              }
            })
          })
          ->Js.Array2.filter(Belt.Option.isSome)
          ->Js.Array2.map(Belt.Option.getExn)
        )

        switch (lessonId, currentIndex, currentInput, totalCharacters, correctCharacters, incorrectCharacters, startTime, errors) {
        | (Some(lid), Some(ci), Some(cin), Some(tc), Some(cc), Some(ic), Some(st), Some(errs)) =>
          Some((lid, {
            currentIndex: ci,
            currentInput: cin,
            stats: {
              totalCharacters: tc,
              correctCharacters: cc,
              incorrectCharacters: ic,
              startTime: st,
              endTime: None,
            },
            errors: errs,
          }))
        | _ => None
        }
      })
    } catch {
    | _ => None
    }
  }
}

// Clear completion stats after they've been used
let clearCompletionStats = (): unit => {
  setItem(completionStatsKey, "")
}

// Character progress tracking
let characterProgressKey = "cangjie_character_progress"

// Encode mastery state to string
let encodeMasteryState = (state: masteryState): string => {
  switch state {
  | New => "new"
  | Introduced => "introduced"
  | Learning => "learning"
  | Weak => "weak"
  | Mastered => "mastered"
  }
}

// Decode mastery state from string
let decodeMasteryState = (str: string): masteryState => {
  switch str {
  | "introduced" => Introduced
  | "learning" => Learning
  | "weak" => Weak
  | "mastered" => Mastered
  | _ => New
  }
}

// Encode character progress to JSON
let encodeCharacterProgress = (cp: characterProgress): Js.Json.t => {
  Js.Dict.fromArray([
    ("character", Js.Json.string(cp.character)),
    ("state", Js.Json.string(encodeMasteryState(cp.state))),
    ("correctCount", Js.Json.number(float_of_int(cp.correctCount))),
    ("incorrectCount", Js.Json.number(float_of_int(cp.incorrectCount))),
    ("lastPracticed", Js.Json.number(cp.lastPracticed)),
    ("timesHintUsed", Js.Json.number(float_of_int(cp.timesHintUsed))),
    ("timesGivenUp", Js.Json.number(float_of_int(cp.timesGivenUp))),
  ])->Js.Json.object_
}

// Decode character progress from JSON
let decodeCharacterProgress = (json: Js.Json.t): option<characterProgress> => {
  json->Js.Json.decodeObject->Belt.Option.flatMap(dict => {
    let character = dict->Js.Dict.get("character")->Belt.Option.flatMap(Js.Json.decodeString)
    let state = dict->Js.Dict.get("state")->Belt.Option.flatMap(Js.Json.decodeString)->Belt.Option.map(decodeMasteryState)
    let correctCount = dict->Js.Dict.get("correctCount")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
    let incorrectCount = dict->Js.Dict.get("incorrectCount")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
    let lastPracticed = dict->Js.Dict.get("lastPracticed")->Belt.Option.flatMap(Js.Json.decodeNumber)
    let timesHintUsed = dict->Js.Dict.get("timesHintUsed")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)
    let timesGivenUp = dict->Js.Dict.get("timesGivenUp")->Belt.Option.flatMap(Js.Json.decodeNumber)->Belt.Option.map(int_of_float)

    switch (character, state, correctCount, incorrectCount, lastPracticed, timesHintUsed, timesGivenUp) {
    | (Some(c), Some(s), Some(cc), Some(ic), Some(lp), Some(thu), Some(tgu)) =>
      Some({
        character: c,
        state: s,
        correctCount: cc,
        incorrectCount: ic,
        lastPracticed: lp,
        timesHintUsed: thu,
        timesGivenUp: tgu,
      })
    | _ => None
    }
  })
}

// Load all character progress
let loadCharacterProgress = (): Js.Dict.t<characterProgress> => {
  switch getItem(characterProgressKey)->Js.Nullable.toOption {
  | None => Js.Dict.empty()
  | Some(str) =>
    try {
      let json = Js.Json.parseExn(str)
      json->Js.Json.decodeObject->Belt.Option.map(dict => {
        let progressDict = Js.Dict.empty()
        dict->Js.Dict.entries->Js.Array2.forEach(((char, charJson)) => {
          decodeCharacterProgress(charJson)->Belt.Option.forEach(cp => {
            Js.Dict.set(progressDict, char, cp)
          })
        })
        progressDict
      })->Belt.Option.getWithDefault(Js.Dict.empty())
    } catch {
    | _ => Js.Dict.empty()
    }
  }
}

// Save all character progress
let saveCharacterProgress = (progressDict: Js.Dict.t<characterProgress>): unit => {
  let jsonDict = Js.Dict.empty()
  progressDict->Js.Dict.entries->Js.Array2.forEach(((char, cp)) => {
    Js.Dict.set(jsonDict, char, encodeCharacterProgress(cp))
  })
  let json = Js.Json.object_(jsonDict)
  setItem(characterProgressKey, Js.Json.stringify(json))
}

// Get progress for a specific character
let getCharacterProgress = (character: string): option<characterProgress> => {
  let allProgress = loadCharacterProgress()
  Js.Dict.get(allProgress, character)
}

// Update progress for a specific character
let updateCharacterProgress = (cp: characterProgress): unit => {
  let allProgress = loadCharacterProgress()
  Js.Dict.set(allProgress, cp.character, cp)
  saveCharacterProgress(allProgress)
}

// Initialize character progress if it doesn't exist
let initCharacterProgress = (character: string): characterProgress => {
  switch getCharacterProgress(character) {
  | Some(cp) => cp
  | None => {
      character: character,
      state: New,
      correctCount: 0,
      incorrectCount: 0,
      lastPracticed: Js.Date.now(),
      timesHintUsed: 0,
      timesGivenUp: 0,
    }
  }
}

// Record a correct attempt
let recordCorrectAttempt = (character: string, showCodeWasVisible: bool): unit => {
  let cp = initCharacterProgress(character)

  let newState = switch (cp.state, showCodeWasVisible) {
  | (New, true) => Introduced
  | (New, false) => Learning
  | (Introduced, false) => Learning
  | (Learning, false) =>
    // Transition to Mastered after 3 correct attempts
    if cp.correctCount + 1 >= 3 {
      Mastered
    } else {
      Learning
    }
  | (Weak, false) =>
    // Transition back to Learning after 2 correct attempts
    if cp.correctCount + 1 >= 2 {
      Learning
    } else {
      Weak
    }
  | (state, _) => state
  }

  updateCharacterProgress({
    ...cp,
    state: newState,
    correctCount: cp.correctCount + 1,
    lastPracticed: Js.Date.now(),
  })
}

// Record an incorrect attempt
let recordIncorrectAttempt = (character: string): unit => {
  let cp = initCharacterProgress(character)
  updateCharacterProgress({
    ...cp,
    incorrectCount: cp.incorrectCount + 1,
    lastPracticed: Js.Date.now(),
  })
}

// Record hint usage
let recordHintUsed = (character: string, isReviewMode: bool): unit => {
  let cp = initCharacterProgress(character)

  // In review mode, mark as Weak when hint is used
  let newState = if isReviewMode && cp.state != New && cp.state != Introduced {
    Weak
  } else {
    cp.state
  }

  updateCharacterProgress({
    ...cp,
    state: newState,
    timesHintUsed: cp.timesHintUsed + 1,
    lastPracticed: Js.Date.now(),
  })
}

// Record give up (counts as error in review mode)
let recordGiveUp = (character: string, isReviewMode: bool): unit => {
  let cp = initCharacterProgress(character)

  // In review mode, mark as Weak and count as incorrect
  let (newState, newIncorrectCount) = if isReviewMode && cp.state != New && cp.state != Introduced {
    (Weak, cp.incorrectCount + 1)
  } else {
    (cp.state, cp.incorrectCount)
  }

  updateCharacterProgress({
    ...cp,
    state: newState,
    incorrectCount: newIncorrectCount,
    timesGivenUp: cp.timesGivenUp + 1,
    lastPracticed: Js.Date.now(),
  })
}

// Get all weak characters (for priority review)
let getWeakCharacters = (): array<string> => {
  let allProgress = loadCharacterProgress()
  allProgress->Js.Dict.entries
    ->Js.Array2.filter(((_, cp)) => cp.state == Weak)
    ->Js.Array2.map(((char, _)) => char)
}

// Get all characters in a specific state
let getCharactersByState = (state: masteryState): array<string> => {
  let allProgress = loadCharacterProgress()
  allProgress->Js.Dict.entries
    ->Js.Array2.filter(((_, cp)) => cp.state == state)
    ->Js.Array2.map(((char, _)) => char)
}

// Get characters that need review (not mastered)
let getCharactersNeedingReview = (): array<string> => {
  let allProgress = loadCharacterProgress()
  allProgress->Js.Dict.entries
    ->Js.Array2.filter(((_, cp)) => cp.state != New && cp.state != Mastered)
    ->Js.Array2.map(((char, _)) => char)
}

// Practice repeat mode settings
let practiceRepeatModeKey = "cangjie-practice-repeat-mode"

// Encode practice repeat mode to string
let encodePracticeRepeatMode = (mode: practiceRepeatMode): string => {
  switch mode {
  | Never => "never"
  | EarliestLesson => "earliest"
  | AnyLesson => "any"
  }
}

// Decode practice repeat mode from string
let decodePracticeRepeatMode = (str: string): practiceRepeatMode => {
  switch str {
  | "never" => Never
  | "any" => AnyLesson
  | _ => EarliestLesson // Default to EarliestLesson
  }
}

// Get practice repeat mode setting
let getPracticeRepeatMode = (): practiceRepeatMode => {
  switch getItem(practiceRepeatModeKey)->Js.Nullable.toOption {
  | None => EarliestLesson // Default
  | Some(str) => decodePracticeRepeatMode(str)
  }
}

// Set practice repeat mode setting
let setPracticeRepeatMode = (mode: practiceRepeatMode): unit => {
  setItem(practiceRepeatModeKey, encodePracticeRepeatMode(mode))
}

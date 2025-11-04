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
}

// Encode user progress to JSON
let encodeProgress = (progress: userProgress): Js.Json.t => {
  Js.Dict.fromArray([
    ("completedLessons", Js.Json.numberArray(progress.completedLessons->Js.Array2.map(float_of_int))),
    ("currentLesson", Js.Json.number(float_of_int(progress.currentLesson))),
    ("placementTestTaken", Js.Json.boolean(progress.placementTestTaken)),
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

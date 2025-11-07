// Lesson list view component - TypingClub style grid layout

open Types

@react.component
let make = (~onLessonSelect: int => unit, ~onBack: unit => unit, ~userProgress: userProgress) => {
  let lessons = CangjieData.getAllLessons()

  let getLessonTypeIcon = (lessonType: lessonType): string => {
    switch lessonType {
    | Introduction => "📚"
    | Practice => "✏️"
    | Test => "📝"
    | Review => "🔄"
    | MixedReview => "🎯"
    | TimedChallenge => "⏱️"
    | PlacementTest => "🏆"
    }
  }

  let getCompletionStars = (accuracy: float): int => {
    if accuracy >= 0.95 {
      3
    } else if accuracy >= 0.85 {
      2
    } else if accuracy >= 0.75 {
      1
    } else {
      0
    }
  }

  <div className="lesson-list-view">
    <div className="lesson-list-header">
      <button className="btn btn-back" onClick={_ => onBack()}>
        {React.string("← 返回")}
      </button>
      <h1> {React.string("選擇課程")} </h1>
    </div>

    <div className="lessons-grid">
      {lessons
      ->Js.Array2.map(lesson => {
        let progress = LocalStorage.getLessonProgress(userProgress, lesson.id)
        let isCompleted = progress->Belt.Option.map(p => p.completed)->Belt.Option.getWithDefault(false)
        let bestAccuracy = progress->Belt.Option.map(p => p.bestAccuracy)->Belt.Option.getWithDefault(0.0)
        let stars = getCompletionStars(bestAccuracy)

        <button
          key={Belt.Int.toString(lesson.id)}
          className={`lesson-tile ${isCompleted ? "completed" : ""} ${lesson.lessonType == Introduction ? "introduction" : ""}`}
          onClick={_ => onLessonSelect(lesson.id)}>

          <div className="lesson-tile-number">
            {React.string(Belt.Int.toString(lesson.id))}
          </div>

          <div className="lesson-tile-icon">
            {React.string(getLessonTypeIcon(lesson.lessonType))}
          </div>

          {lesson.introducedKeys->Js.Array2.length > 0
            ? <div className="lesson-tile-keys">
                {lesson.introducedKeys
                ->Js.Array2.slice(~start=0, ~end_=5)
                ->Js.Array2.map(key => {
                  <span key={CangjieUtils.keyToString(key)} className="key-indicator">
                    {React.string(CangjieUtils.keyToRadicalName(key))}
                  </span>
                })
                ->React.array}
              </div>
            : <div className="lesson-tile-title">
                {React.string(lesson.title->Js.String2.slice(~from=0, ~to_=8))}
              </div>}

          {isCompleted
            ? <div className="lesson-tile-stars">
                {Belt.Array.range(0, stars - 1)
                ->Js.Array2.map(i => {
                  <span key={Belt.Int.toString(i)} className="star">
                    {React.string("⭐")}
                  </span>
                })
                ->React.array}
              </div>
            : <div className="lesson-tile-status">
                {React.string("開始")}
              </div>}
        </button>
      })
      ->React.array}
    </div>
  </div>
}

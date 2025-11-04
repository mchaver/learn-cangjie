// Lesson list view component

open Types

@react.component
let make = (~onLessonSelect: int => unit, ~onBack: unit => unit, ~userProgress: userProgress) => {
  let lessons = CangjieData.getAllLessons()

  let getLessonTypeIcon = (lessonType: lessonType): string => {
    switch lessonType {
    | Introduction => "📖"
    | Practice => "✍️"
    | Test => "📝"
    }
  }

  let getLessonTypeLabel = (lessonType: lessonType): string => {
    switch lessonType {
    | Introduction => "介紹"
    | Practice => "練習"
    | Test => "測驗"
    }
  }

  <div className="lesson-list-view">
    <div className="lesson-list-header">
      <button className="btn btn-back" onClick={_ => onBack()}>
        {React.string("← 返回")}
      </button>
      <h1> {React.string("課程列表")} </h1>
    </div>

    <div className="lesson-list">
      {lessons
      ->Js.Array2.map(lesson => {
        let progress = LocalStorage.getLessonProgress(userProgress, lesson.id)
        let isCompleted = progress->Belt.Option.map(p => p.completed)->Belt.Option.getWithDefault(false)
        let bestAccuracy = progress->Belt.Option.map(p => p.bestAccuracy)->Belt.Option.getWithDefault(0.0)
        let bestSpeed = progress->Belt.Option.map(p => p.bestSpeed)->Belt.Option.getWithDefault(0.0)

        <div
          key={Belt.Int.toString(lesson.id)}
          className={`lesson-item ${isCompleted ? "completed" : ""}`}
          onClick={_ => onLessonSelect(lesson.id)}>
          <div className="lesson-item-header">
            <div className="lesson-type">
              <span className="lesson-type-icon">
                {React.string(getLessonTypeIcon(lesson.lessonType))}
              </span>
              <span className="lesson-type-label">
                {React.string(getLessonTypeLabel(lesson.lessonType))}
              </span>
            </div>
            {isCompleted
              ? <span className="lesson-status-badge completed"> {React.string("✓ 已完成")} </span>
              : <span className="lesson-status-badge"> {React.string("未完成")} </span>}
          </div>

          <h3 className="lesson-title"> {React.string(lesson.title)} </h3>
          <p className="lesson-description"> {React.string(lesson.description)} </p>

          {lesson.introducedKeys->Js.Array2.length > 0
            ? <div className="lesson-keys">
                <span className="lesson-keys-label"> {React.string("新字根：")} </span>
                {lesson.introducedKeys
                ->Js.Array2.map(key => {
                  <span key={CangjieUtils.keyToString(key)} className="key-badge">
                    {React.string(
                      `${CangjieUtils.keyToString(key)} (${CangjieUtils.keyToRadicalName(key)})`,
                    )}
                  </span>
                })
                ->React.array}
              </div>
            : React.null}

          {progress->Belt.Option.isSome
            ? <div className="lesson-stats">
                <span className="lesson-stat">
                  {React.string(`準確率: ${Js.Float.toFixedWithPrecision(bestAccuracy *. 100.0, ~digits=1)}%`)}
                </span>
                <span className="lesson-stat">
                  {React.string(`速度: ${Js.Float.toFixedWithPrecision(bestSpeed, ~digits=1)} 字/分鐘`)}
                </span>
              </div>
            : React.null}
        </div>
      })
      ->React.array}
    </div>
  </div>
}

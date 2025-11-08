// Lesson list view component - Organized by sections

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

  let getSectionTitle = (section: lessonSection): string => {
    switch section {
    | Philosophy => "哲理類"
    | Strokes => "筆畫類"
    | BodyParts => "人體類"
    | CharacterShapes => "字形類"
    | SpecialKeys => "特殊鍵"
    | TopCommon => "前100個字"
    | Advanced => "進階"
    }
  }

  let getSectionDescription = (section: lessonSection): string => {
    switch section {
    | Philosophy => "五行：金木水火土"
    | Strokes => "基礎筆畫：日月一大十田"
    | BodyParts => "身體部位：人心手"
    | CharacterShapes => "常見字形：口中山女竹戈"
    | SpecialKeys => "特殊按鍵"
    | TopCommon => "最常用的100個字"
    | Advanced => "進階課程"
    }
  }

  // Group lessons by section
  let groupLessonsBySection = (lessons: array<lesson>): array<(lessonSection, array<lesson>)> => {
    let sections = [Philosophy, Strokes, BodyParts, CharacterShapes, SpecialKeys, TopCommon, Advanced]
    sections
    ->Js.Array2.map(section => {
      let sectionLessons = lessons->Js.Array2.filter(lesson => lesson.section == section)
      (section, sectionLessons)
    })
    ->Js.Array2.filter(((_, sectionLessons)) => sectionLessons->Js.Array2.length > 0)
  }

  let renderLesson = (lesson: lesson) => {
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
            {React.string(lesson.title->Js.String2.slice(~from=0, ~to_=12))}
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
  }

  let groupedLessons = groupLessonsBySection(lessons)

  <div className="lesson-list-view">
    <div className="lesson-list-header">
      <button className="btn btn-back" onClick={_ => onBack()}>
        {React.string("← 返回")}
      </button>
      <h1> {React.string("選擇課程")} </h1>
    </div>

    <div className="lessons-sections">
      {groupedLessons
      ->Js.Array2.map(((section, sectionLessons)) => {
        <div key={getSectionTitle(section)} className="lesson-section">
          <div className="section-header">
            <h2 className="section-title"> {React.string(getSectionTitle(section))} </h2>
            <p className="section-description"> {React.string(getSectionDescription(section))} </p>
          </div>
          <div className="lessons-grid">
            {sectionLessons->Js.Array2.map(renderLesson)->React.array}
          </div>
        </div>
      })
      ->React.array}
    </div>
  </div>
}

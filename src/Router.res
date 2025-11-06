// Router module - handles URL routing for the application

// Route sum type representing all possible routes in the app
type route =
  | Home
  | LessonList
  | LessonIntro(int) // /lesson/:id/intro
  | LessonPractice(int) // /lesson/:id/practice
  | Dictionary
  | LessonGenerator
  | NotFound

// Parse URL path to route
let urlToRoute = (url: RescriptReactRouter.url): route => {
  switch url.path {
  | list{} => Home
  | list{"lessons"} => LessonList
  | list{"lesson", id, "intro"} =>
    switch Belt.Int.fromString(id) {
    | Some(lessonId) => LessonIntro(lessonId)
    | None => NotFound
    }
  | list{"lesson", id, "practice"} =>
    switch Belt.Int.fromString(id) {
    | Some(lessonId) => LessonPractice(lessonId)
    | None => NotFound
    }
  | list{"dictionary"} => Dictionary
  | list{"generator"} => LessonGenerator
  | _ => NotFound
  }
}

// Convert route to URL path
let routeToUrl = (route: route): string => {
  switch route {
  | Home => "/"
  | LessonList => "/lessons"
  | LessonIntro(id) => `/lesson/${Belt.Int.toString(id)}/intro`
  | LessonPractice(id) => `/lesson/${Belt.Int.toString(id)}/practice`
  | Dictionary => "/dictionary"
  | LessonGenerator => "/generator"
  | NotFound => "/404"
  }
}

// Push a new route to browser history
let push = (route: route): unit => {
  let url = routeToUrl(route)
  RescriptReactRouter.push(url)
}

// Replace current route in browser history
let replace = (route: route): unit => {
  let url = routeToUrl(route)
  RescriptReactRouter.replace(url)
}

// Hook to get current route
let useRoute = (): route => {
  let url = RescriptReactRouter.useUrl()
  urlToRoute(url)
}

// Router module - handles URL routing for the application

// Route sum type representing all possible routes in the app
type route =
  | Home
  | LessonList
  | Lesson(int) // /lesson/:id
  | Dictionary
  | LessonGenerator
  | NotFound

// Parse URL path to route
let urlToRoute = (url: RescriptReactRouter.url): route => {
  switch url.path {
  | list{} => Home
  | list{"lessons"} => LessonList
  | list{"lesson", id} =>
    switch Belt.Int.fromString(id) {
    | Some(lessonId) => Lesson(lessonId)
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
  | Lesson(id) => `/lesson/${Belt.Int.toString(id)}`
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

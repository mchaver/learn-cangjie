// Core types for the Cangjie learning app

// Cangjie radical codes (the 24 basic radicals + X)
type cangjieKey =
  | A | B | C | D | E | F | G | H | I | J | K | L | M
  | N | O | P | Q | R | S | T | U | V | W | X | Y | Z

// Character with its Cangjie decomposition
type characterInfo = {
  character: string,
  cangjieCode: array<cangjieKey>,
  radicals: option<array<string>>, // Visual breakdown of radicals
}

// Lesson type
type lessonType =
  | Introduction  // Learn new radicals
  | Practice      // Practice with hints
  | Test         // Timed test without hints

// A single lesson
type lesson = {
  id: int,
  title: string,
  description: string,
  lessonType: lessonType,
  introducedKeys: array<cangjieKey>, // Keys introduced in this lesson
  characters: array<characterInfo>,
  targetAccuracy: float, // e.g., 0.90 for 90%
  targetSpeed: option<float>, // characters per minute
}

// User's progress for a lesson
type lessonProgress = {
  lessonId: int,
  completed: bool,
  bestAccuracy: float,
  bestSpeed: float, // CPM - characters per minute
  attemptCount: int,
  lastAttemptDate: option<Js.Date.t>,
}

// User's overall progress
type userProgress = {
  completedLessons: array<int>,
  lessonProgress: array<lessonProgress>,
  currentLesson: int,
  placementTestTaken: bool,
}

// Typing session statistics
type typingStats = {
  totalCharacters: int,
  correctCharacters: int,
  incorrectCharacters: int,
  startTime: float,
  endTime: option<float>,
}

// User input state during practice
type inputState = {
  currentIndex: int,
  currentInput: string,
  stats: typingStats,
  errors: array<(int, string)>, // (characterIndex, incorrectInput)
}

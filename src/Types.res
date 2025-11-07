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
  hskLevel: option<int>, // HSK 1-6 or None
  frequencyRank: option<int>, // Frequency ranking (1 = most common)
}

// Lesson category
type lessonCategory =
  | Radicals      // Basic radicals
  | CommonWords   // Common 2-3 character words
  | Phrases       // Longer phrases
  | Chengyu       // 成語 (4-character idioms)
  | Sentences     // Full sentences
  | Custom        // User-created lessons

// Lesson type
type lessonType =
  | Introduction   // Learn new radicals
  | Practice       // Practice with hints
  | Test           // Timed test without hints
  | Review         // Review previous lessons with randomization
  | TimedChallenge // Type as many as possible in time limit
  | PlacementTest  // Determine user's level

// A single lesson
type lesson = {
  id: int,
  title: string,
  description: string,
  category: lessonCategory,
  lessonType: lessonType,
  introducedKeys: array<cangjieKey>, // Keys introduced in this lesson
  characters: array<characterInfo>,
  targetAccuracy: float, // e.g., 0.90 for 90%
  targetSpeed: option<float>, // characters per minute
  showCode: bool, // Whether to show Cangjie code during practice
  allowHints: bool, // Whether "Show Hint" button is available
  allowGiveUp: bool, // Whether "Give Up" button is available
  reviewsLessons: array<int>, // Which lesson IDs this reviews (empty for new content)
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

// Placement test result
type placementResult = {
  accuracy: float,
  speed: float,
  recommendedLessonId: int,
  date: Js.Date.t,
}

// User's overall progress
type userProgress = {
  completedLessons: array<int>,
  lessonProgress: array<lessonProgress>,
  currentLesson: int,
  placementTestTaken: bool,
  placementResult: option<placementResult>,
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

// Character mastery state
type masteryState =
  | New           // Never seen
  | Introduced    // Seen with code visible
  | Learning      // Practiced without code
  | Weak          // User clicked "Show Hint" or gave up
  | Mastered      // Typed correctly multiple times

// Individual character progress tracking
type characterProgress = {
  character: string,
  state: masteryState,
  correctCount: int,
  incorrectCount: int,
  lastPracticed: float, // timestamp
  timesHintUsed: int,
  timesGivenUp: int,
}

// Utilities for working with Cangjie input

open Types

// Convert Cangjie key to string
let keyToString = (key: cangjieKey): string => {
  switch key {
  | A => "A" | B => "B" | C => "C" | D => "D" | E => "E"
  | F => "F" | G => "G" | H => "H" | I => "I" | J => "J"
  | K => "K" | L => "L" | M => "M" | N => "N" | O => "O"
  | P => "P" | Q => "Q" | R => "R" | S => "S" | T => "T"
  | U => "U" | V => "V" | W => "W" | X => "X" | Y => "Y"
  | Z => "Z"
  }
}

// Get the Cangjie radical name in Traditional Chinese
let keyToRadicalName = (key: cangjieKey): string => {
  switch key {
  | A => "日" | B => "月" | C => "金" | D => "木" | E => "水"
  | F => "火" | G => "土" | H => "竹" | I => "戈" | J => "十"
  | K => "大" | L => "中" | M => "一" | N => "弓" | O => "人"
  | P => "心" | Q => "手" | R => "口" | S => "尸" | T => "廿"
  | U => "山" | V => "女" | W => "田" | X => "難" | Y => "卜"
  | Z => "Z" // Reserved/special
  }
}

// Parse string to cangjie key
let stringToKey = (str: string): option<cangjieKey> => {
  switch str->Js.String2.toUpperCase {
  | "A" => Some(A) | "B" => Some(B) | "C" => Some(C) | "D" => Some(D)
  | "E" => Some(E) | "F" => Some(F) | "G" => Some(G) | "H" => Some(H)
  | "I" => Some(I) | "J" => Some(J) | "K" => Some(K) | "L" => Some(L)
  | "M" => Some(M) | "N" => Some(N) | "O" => Some(O) | "P" => Some(P)
  | "Q" => Some(Q) | "R" => Some(R) | "S" => Some(S) | "T" => Some(T)
  | "U" => Some(U) | "V" => Some(V) | "W" => Some(W) | "X" => Some(X)
  | "Y" => Some(Y) | "Z" => Some(Z)
  | _ => None
  }
}

// Convert array of keys to code string (e.g., [A, B, C] => "ABC")
let keysToCode = (keys: array<cangjieKey>): string => {
  keys->Js.Array2.map(keyToString)->Js.Array2.joinWith("")
}

// Parse code string to array of keys
let codeToKeys = (code: string): array<cangjieKey> => {
  code
  ->Js.String2.split("")
  ->Js.Array2.map(stringToKey)
  ->Js.Array2.filter(opt => opt->Belt.Option.isSome)
  ->Js.Array2.map(opt => opt->Belt.Option.getExn)
}

// Calculate typing accuracy
let calculateAccuracy = (correct: int, total: int): float => {
  if total == 0 {
    0.0
  } else {
    float_of_int(correct) /. float_of_int(total)
  }
}

// Calculate characters per minute
let calculateCPM = (characters: int, milliseconds: float): float => {
  if milliseconds <= 0.0 {
    0.0
  } else {
    let minutes = milliseconds /. 60000.0
    float_of_int(characters) /. minutes
  }
}

// Shuffle an array using Fisher-Yates algorithm
let shuffleArray = (arr: array<'a>): array<'a> => {
  let shuffled = arr->Js.Array2.copy
  let length = shuffled->Js.Array2.length

  for i in 0 to length - 1 {
    // Generate random index from i to end of array
    let j = i + Js.Math.floor(Js.Math.random() *. float_of_int(length - i))

    // Swap elements
    let temp = shuffled[i]
    shuffled[i] = shuffled[j]
    shuffled[j] = temp
  }

  shuffled
}

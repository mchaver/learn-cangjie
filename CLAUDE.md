# Claude AI Development Guide

## Cangjie Resources

### Theory and Understanding

These resources explain how Cangjie decomposes characters and 

https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95
https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95/%E5%9F%BA%E6%9C%AC%E5%8F%96%E7%A2%BC
https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95/%E5%8F%96%E7%A2%BC%E5%8E%9F%E5%89%87
https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95/%E4%BE%8B%E5%A4%96%E5%AD%97
https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95/%E7%89%B9%E5%88%A5%E6%B3%A8%E6%84%8F
https://zh.wikibooks.org/wiki/%E5%80%89%E9%A0%A1%E8%BC%B8%E5%85%A5%E6%B3%95/%E7%89%88%E6%9C%AC%E5%B7%AE%E7%95%B0

### Database

- We have the Cangjie version 5 database in /dist/assets/cangjie5.txt
- Whenever Claude needs to lookup a Cangjie code, do so in the file mentioned above

## ReScript/React Reference

For ReScript and React development in this project, please refer to:
https://rescript-lang.org/llms/react/latest/llm-full.txt

This comprehensive guide provides the complete API reference for ReScript with React, including:
- JSX syntax
- Component definitions
- Hooks usage
- Type definitions
- Common patterns and idioms
- External bindings

### Best Practices

#### Avoid These Patterns

1. **Avoid `%raw` blocks if possible** - When you encounter JavaScript interop needs, write proper bindings with explicit types. Find ReScript-native solutions for all problems rather than escaping to JavaScript. Only use raw if it is absolutely necessary.
2. **Never use `Obj.magic`** - it breaks type safety
3. **Avoid `any` types** - be specific
4. **Don't use exceptions for control flow** - use Result types
5. **Avoid imperative loops** - use Array/List functions
6. **Never chain promises with `then_`** - use async/await
7. **Don't add unnecessary module imports** - ReScript modules are globally available
8. **Don't add `let default = make`** - Components are exported automatically
9. **Don't do `let _ = ...`** - use `->ignore` instead

#### Embrace These Patterns

1. **Pattern match exhaustively** - handle all cases
2. **Use Option for nullable values** - avoid null/undefined
3. **Create small, focused modules** - single responsibility
4. **Write pure functions** - no side effects (except in useEffect for React components)
5. **Document with types** - types are documentation
6. **Use modern React hooks** - useState, useEffect, useReducer, custom hooks
7. **Keep state local** - lift it only when necessary
8. **Consider React optimizations** - React.memo, useMemo, useCallback but only when measurably needed

## Project Overview

**倉頡鍵客 (Cangjie Typing Master)** is a Cangjie (倉頡) input method learning application built with ReScript and React. It helps Chinese speakers master typing using the Cangjie input method through a series of progressive lessons, practice sessions, and tests.

## Technology Stack

- **ReScript** - Type-safe language that compiles to JavaScript
- **React 18** - UI framework
- **Vite** - Build tool and dev server
- **SCSS** - Styling

## Project Structure

```
src/
├── Types.res              - Core type definitions
├── CangjieUtils.res       - Utility functions for Cangjie input
├── CangjieData.res        - Lesson data and character database
├── LocalStorage.res       - Progress tracking persistence
├── App.res                - Main application component
├── HomeView.res           - Home screen
├── LessonListView.res     - Lesson selection screen
├── LessonView.res         - Main lesson container
├── IntroductionMode.res   - Introduction/teaching mode
├── ReadyScreen.res        - Pre-lesson ready screen
├── PracticeMode.res       - Practice mode with hints
├── TestMode.res           - Timed test mode
├── CharacterDisplay.res   - Character display with hover hints
├── CompletionScreen.res   - Lesson completion screen
└── styles/
    └── main.scss          - Application styles
```

## Key Features

1. **Progressive Learning** - 5 radicals introduced per lesson
2. **Practice Mode** - Hints available on hover, focus on accuracy
3. **Test Mode** - Timed tests with performance tracking
4. **Progress Tracking** - LocalStorage persistence of user progress
5. **Responsive Design** - Mobile-friendly interface
6. **Traditional Chinese** - All content uses Traditional Chinese characters

## Development Commands

```bash
npm install          # Install dependencies
npm run dev          # Start dev server
npm run build        # Build for production
npm run res:build    # Build ReScript only
npm run res:watch    # Watch mode for ReScript
```

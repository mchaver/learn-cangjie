# Claude AI Development Guide

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

## Project Overview

This is a Cangjie (倉頡) input method learning application built with ReScript and React. It helps Chinese speakers learn how to type using the Cangjie input method through a series of progressive lessons, practice sessions, and tests.

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

# 學習倉頡輸入法 (Learn Cangjie Input Method)

A progressive web application for learning the Cangjie (倉頡) input method, built with ReScript and React.

## Features

- 📚 **Progressive Lessons** - Learn Cangjie radicals step by step, 5 at a time
- ✍️ **Practice Mode** - Practice with visual hints and decomposition on hover
- 📝 **Test Mode** - Timed tests to assess your proficiency
- 📊 **Progress Tracking** - Track your accuracy, speed (CPM), and completion
- 💾 **Auto-save** - Your progress is automatically saved to localStorage
- 📱 **Responsive** - Works on desktop and mobile devices
- 🇹🇼 **Traditional Chinese** - All content uses Traditional Chinese characters

## Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/learn-cangjie.git
cd learn-cangjie

# Install dependencies
npm install

# Start development server
npm run dev
```

The app will be available at `http://localhost:3000`

### Build for Production

```bash
npm run build
```

The production build will be in the `dist/` directory.

## Development

### ReScript Development

```bash
# Build ReScript files
npm run res:build

# Watch mode for ReScript (auto-rebuild on changes)
npm run res:watch
```

### Project Structure

- `src/` - ReScript source code
  - `Types.res` - Type definitions
  - `CangjieData.res` - Lesson and character data
  - `CangjieUtils.res` - Utility functions
  - `LocalStorage.res` - Progress persistence
  - `*View.res`, `*Mode.res` - UI components
  - `styles/` - SCSS stylesheets

## How It Works

### Lesson Progression

1. **Introduction** - Learn 5 new Cangjie radicals with their meanings
2. **Practice** - Practice typing characters using the learned radicals (with hints)
3. **Test** - Timed test to validate your understanding (no hints)

### Cangjie 5 Radicals

The app teaches all 24 basic Cangjie radicals:

| Key | Radical | Meaning |
|-----|---------|---------|
| A   | 日      | Sun     |
| B   | 月      | Moon    |
| C   | 金      | Metal   |
| D   | 木      | Wood    |
| E   | 水      | Water   |
| ... | ...     | ...     |

### Progress Tracking

- **Accuracy** - Percentage of correct inputs
- **Speed** - Characters per minute (CPM)
- **Completion** - Track which lessons you've completed
- **Best Scores** - Your best accuracy and speed for each lesson

## Technology Stack

- **[ReScript](https://rescript-lang.org/)** - Type-safe language compiled to JavaScript
- **[React 18](https://react.dev/)** - UI framework
- **[Vite](https://vitejs.dev/)** - Build tool and dev server
- **[SCSS](https://sass-lang.com/)** - CSS preprocessor

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Cangjie input method created by Chu Bong-Foo (朱邦復)
- Character decomposition data based on Cangjie 5 specification

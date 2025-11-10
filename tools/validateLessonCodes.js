/**
 * Validate all character codes in CangjieData.res against cangjie5.txt
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { parseCangjieDatabase, validateCode } from './cangjieParser.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Extract all makeChar calls from CangjieData.res
 * Pattern: makeChar("字", "CODE", ...)
 */
function extractCharactersFromLessons(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.split('\n');

  const characters = [];
  const makeCharRegex = /makeChar\("([^"]+)",\s*"([^"]+)"/g;

  let lineNumber = 0;
  for (const line of lines) {
    lineNumber++;
    let match;
    while ((match = makeCharRegex.exec(line)) !== null) {
      const char = match[1];
      const code = match[2];
      characters.push({
        char,
        code,
        line: lineNumber,
        lineContent: line.trim()
      });
    }
  }

  return characters;
}

/**
 * Find which lesson a character belongs to
 */
function findLessonContext(line, fileContent) {
  const lines = fileContent.split('\n');

  // Search backwards from the line to find the lesson array name
  for (let i = line - 1; i >= 0; i--) {
    const currentLine = lines[i];
    if (currentLine.includes('let ') && currentLine.includes('Characters = [')) {
      const match = currentLine.match(/let (\w+Characters) = \[/);
      if (match) {
        return match[1];
      }
    }
    // Stop if we hit another array or function
    if (currentLine.includes('let ') && currentLine.includes(' = [')) {
      break;
    }
  }

  return 'unknown';
}

/**
 * Main validation function
 */
function validateAllCodes() {
  console.log('🔍 Cangjie Code Validator\n');
  console.log('Loading cangjie5.txt database...');

  const database = parseCangjieDatabase();
  console.log(`✓ Loaded ${database.size} characters from database\n`);

  console.log('Extracting characters from CangjieData.res...');
  const dataFilePath = path.join(__dirname, '../src/CangjieData.res');
  const fileContent = fs.readFileSync(dataFilePath, 'utf-8');
  const characters = extractCharactersFromLessons(dataFilePath);
  console.log(`✓ Found ${characters.length} character instances\n`);

  console.log('Validating codes...\n');

  const errors = [];
  const notFound = [];
  let validCount = 0;

  for (const char of characters) {
    const result = validateCode(database, char.char, char.code);

    if (result.actual === null) {
      notFound.push({
        ...char,
        lesson: findLessonContext(char.line, fileContent)
      });
    } else if (!result.valid) {
      errors.push({
        ...char,
        correctCode: result.actual,
        lesson: findLessonContext(char.line, fileContent)
      });
    } else {
      validCount++;
    }
  }

  // Print results
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`✓ Valid:     ${validCount}`);
  console.log(`✗ Incorrect: ${errors.length}`);
  console.log(`? Not Found: ${notFound.length}`);
  console.log('═══════════════════════════════════════════════════════════\n');

  if (errors.length > 0) {
    console.log('❌ INCORRECT CODES FOUND:\n');

    // Group by lesson
    const byLesson = {};
    for (const error of errors) {
      if (!byLesson[error.lesson]) {
        byLesson[error.lesson] = [];
      }
      byLesson[error.lesson].push(error);
    }

    for (const [lesson, errs] of Object.entries(byLesson)) {
      console.log(`📚 ${lesson}:`);
      for (const err of errs) {
        console.log(`  Line ${err.line}: ${err.char}`);
        console.log(`    Expected: "${err.code}" → Should be: "${err.correctCode}"`);
        console.log(`    ${err.lineContent}`);
        console.log('');
      }
    }
  }

  if (notFound.length > 0) {
    console.log('❓ CHARACTERS NOT IN DATABASE:\n');

    const byLesson = {};
    for (const nf of notFound) {
      if (!byLesson[nf.lesson]) {
        byLesson[nf.lesson] = [];
      }
      byLesson[nf.lesson].push(nf);
    }

    for (const [lesson, nfs] of Object.entries(byLesson)) {
      console.log(`📚 ${lesson}:`);
      for (const nf of nfs) {
        console.log(`  Line ${nf.line}: ${nf.char} (code: "${nf.code}")`);
        console.log(`    ${nf.lineContent}`);
        console.log('');
      }
    }
  }

  if (errors.length === 0 && notFound.length === 0) {
    console.log('✅ ALL CODES ARE CORRECT! 🎉\n');
    return true;
  } else {
    console.log('❌ Validation failed. Please fix the errors above.\n');
    return false;
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  const success = validateAllCodes();
  process.exit(success ? 0 : 1);
}

export { validateAllCodes, extractCharactersFromLessons };

/**
 * Automatically fix incorrect codes in CangjieData.res
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { parseCangjieDatabase, validateCode } from './cangjieParser.js';
import { extractCharactersFromLessons } from './validateLessonCodes.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Fix all incorrect codes in CangjieData.res
 */
function fixAllCodes() {
  console.log('🔧 Cangjie Code Auto-Fixer\n');
  console.log('Loading cangjie5.txt database...');

  const database = parseCangjieDatabase();
  console.log(`✓ Loaded ${database.size} characters from database\n`);

  console.log('Reading CangjieData.res...');
  const dataFilePath = path.join(__dirname, '../src/CangjieData.res');
  let content = fs.readFileSync(dataFilePath, 'utf-8');
  const characters = extractCharactersFromLessons(dataFilePath);
  console.log(`✓ Found ${characters.length} character instances\n`);

  console.log('Finding incorrect codes...\n');

  const fixes = [];

  for (const char of characters) {
    const result = validateCode(database, char.char, char.code);

    if (result.actual && !result.valid) {
      fixes.push({
        char: char.char,
        oldCode: char.code,
        newCode: result.actual,
        line: char.line
      });
    }
  }

  console.log(`Found ${fixes.length} incorrect codes to fix\n`);

  if (fixes.length === 0) {
    console.log('✅ No fixes needed!\n');
    return true;
  }

  // Group fixes by character for summary
  const byChar = {};
  for (const fix of fixes) {
    if (!byChar[fix.char]) {
      byChar[fix.char] = { oldCode: fix.oldCode, newCode: fix.newCode, count: 0 };
    }
    byChar[fix.char].count++;
  }

  console.log('📝 Fixes to apply:\n');
  for (const [char, info] of Object.entries(byChar)) {
    console.log(`  ${char}: "${info.oldCode}" → "${info.newCode}" (${info.count} instances)`);
  }
  console.log('');

  // Apply fixes by replacing strings
  let fixedCount = 0;
  for (const [char, info] of Object.entries(byChar)) {
    const oldPattern = `makeChar("${char}", "${info.oldCode}"`;
    const newPattern = `makeChar("${char}", "${info.newCode}"`;

    // Count occurrences
    const matches = (content.match(new RegExp(oldPattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g')) || []).length;

    content = content.replaceAll(oldPattern, newPattern);

    fixedCount += matches;
    console.log(`✓ Fixed ${matches} instances of ${char}: "${info.oldCode}" → "${info.newCode}"`);
  }

  console.log(`\n💾 Writing fixed content back to file...`);
  fs.writeFileSync(dataFilePath, content, 'utf-8');
  console.log(`✅ Fixed ${fixedCount} codes in CangjieData.res\n`);

  return true;
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  fixAllCodes();
}

export { fixAllCodes };

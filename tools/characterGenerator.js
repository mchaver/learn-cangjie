/**
 * Character Generator Utility
 * Generate makeChar() calls with verified codes from cangjie5.txt
 */

import { parseCangjieDatabase, getCodes } from './cangjieParser.js';

/**
 * Generate a single makeChar call
 * @param {string} char - The character
 * @param {string} code - The cangjie code (uppercase)
 * @param {string[]} radicals - Optional radical decomposition
 * @param {string} comment - Optional comment
 * @returns {string} ReScript makeChar code
 */
function generateMakeChar(char, code, radicals = null, comment = null) {
  let result = `makeChar("${char}", "${code}"`;

  if (radicals && radicals.length > 0) {
    const radicalsStr = radicals.map(r => `"${r}"`).join(', ');
    result += `, Some([${radicalsStr}])`;
  } else {
    result += `, None`;
  }

  result += `, ())`;

  if (comment) {
    result += `, // ${comment}`;
  }

  return result;
}

/**
 * Generate makeChar calls for multiple characters
 * @param {Map} database - Cangjie database
 * @param {string[]} characters - Array of characters
 * @param {Object} options - {withRadicals: boolean, comments: Object}
 * @returns {string[]} Array of makeChar code lines
 */
function generateMakeChars(database, characters, options = {}) {
  const { withRadicals = false, comments = {} } = options;

  const results = getCodes(database, characters);
  const lines = [];

  for (const result of results) {
    if (!result.found) {
      lines.push(`// ❌ NOT FOUND: ${result.char}`);
      continue;
    }

    const comment = comments[result.char];
    const radicals = withRadicals ? null : null; // Would need separate radical data
    const line = generateMakeChar(result.char, result.code, radicals, comment);
    lines.push(line);
  }

  return lines;
}

/**
 * Lookup and display character codes
 * @param {string[]} characters - Characters to look up
 */
function lookupCharacters(characters) {
  console.log('🔍 Cangjie Character Lookup\n');

  const database = parseCangjieDatabase();
  const results = getCodes(database, characters);

  console.log('Character | Code   | Status');
  console.log('----------|--------|--------');

  for (const result of results) {
    const status = result.found ? '✓' : '✗ NOT FOUND';
    const code = result.code || 'N/A';
    console.log(`${result.char}         | ${code.padEnd(6)} | ${status}`);
  }

  console.log('\n');

  // Generate ReScript code
  if (results.some(r => r.found)) {
    console.log('📝 Generated ReScript code:\n');
    const lines = generateMakeChars(database, characters);
    for (const line of lines) {
      console.log(`  ${line}`);
    }
    console.log('');
  }
}

/**
 * Interactive character lookup from command line
 */
function interactiveLookup() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.log('Usage: node characterGenerator.js [characters...]');
    console.log('Example: node characterGenerator.js 明 林 炎 好');
    console.log('');
    console.log('You can also pass characters as a single string:');
    console.log('Example: node characterGenerator.js 明林炎好');
    process.exit(0);
  }

  // Parse input - either individual args or split a single string
  let characters = [];
  for (const arg of args) {
    if (arg.length === 1) {
      characters.push(arg);
    } else {
      // Split multi-character string
      characters.push(...arg.split(''));
    }
  }

  lookupCharacters(characters);
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  interactiveLookup();
}

export {
  generateMakeChar,
  generateMakeChars,
  lookupCharacters
};

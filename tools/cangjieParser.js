/**
 * Cangjie Database Parser
 * Parses cangjie5.txt into a lookup map for validation and code generation
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Parse cangjie5.txt file
 * Format: code\tcharacter\tfrequency
 * Example: ab	明	1000
 *
 * @returns {Map<string, string>} Map of character -> uppercase code
 */
function parseCangjieDatabase(filePath = '../public/assets/cangjie5.txt') {
  const fullPath = path.join(__dirname, filePath);
  const content = fs.readFileSync(fullPath, 'utf-8');
  const lines = content.split('\n');

  const charToCode = new Map();

  for (const line of lines) {
    if (!line.trim()) continue;

    const parts = line.split('\t');
    if (parts.length < 2) continue;

    const code = parts[0].trim().toUpperCase();
    const char = parts[1].trim();

    if (char && code) {
      // Store first occurrence (most common)
      if (!charToCode.has(char)) {
        charToCode.set(char, code);
      }
    }
  }

  return charToCode;
}

/**
 * Get code for a character
 * @param {Map<string, string>} database
 * @param {string} character
 * @returns {string|null} Uppercase code or null if not found
 */
function getCode(database, character) {
  return database.get(character) || null;
}

/**
 * Get codes for multiple characters
 * @param {Map<string, string>} database
 * @param {string[]} characters
 * @returns {Object[]} Array of {char, code, found}
 */
function getCodes(database, characters) {
  return characters.map(char => ({
    char,
    code: database.get(char) || null,
    found: database.has(char)
  }));
}

/**
 * Validate a character's code
 * @param {Map<string, string>} database
 * @param {string} character
 * @param {string} expectedCode
 * @returns {{valid: boolean, char: string, expected: string, actual: string|null}}
 */
function validateCode(database, character, expectedCode) {
  const actualCode = database.get(character);
  const expected = expectedCode.toUpperCase();

  return {
    valid: actualCode === expected,
    char: character,
    expected,
    actual: actualCode || null
  };
}

export {
  parseCangjieDatabase,
  getCode,
  getCodes,
  validateCode
};

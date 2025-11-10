# Cangjie Lesson Development Tools

Utilities for creating and validating Cangjie lesson content.

## Tools

### 1. Code Validator (`validateLessonCodes.js`)

Validates all character codes in `CangjieData.res` against `cangjie5.txt`.

**Usage:**
```bash
npm run validate:codes
```

**What it does:**
- Parses all `makeChar()` calls in CangjieData.res
- Checks each character code against cangjie5.txt
- Reports:
  - ✓ Valid codes
  - ✗ Incorrect codes (with correct codes)
  - ? Characters not found in database

**Example output:**
```
✓ Valid:     1234
✗ Incorrect: 3
? Not Found: 0

❌ INCORRECT CODES FOUND:

📚 philosophyApplicationCharacters:
  Line 712: 杲
    Expected: "DA" → Should be: "AD"
    makeChar("杲", "DA", Some(["日", "木"]), ()),
```

### 2. Character Generator (`characterGenerator.js`)

Generates verified `makeChar()` calls for characters.

**Usage:**
```bash
npm run generate:chars 明 林 炎 好
# or
npm run generate:chars 明林炎好
```

**What it does:**
- Looks up characters in cangjie5.txt
- Generates properly formatted makeChar() calls
- Shows codes in table format

**Example output:**
```
Character | Code   | Status
----------|--------|--------
明         | AB     | ✓
林         | DD     | ✓
炎         | FF     | ✓
好         | VND    | ✓

📝 Generated ReScript code:

  makeChar("明", "AB", None, ()),
  makeChar("林", "DD", None, ()),
  makeChar("炎", "FF", None, ()),
  makeChar("好", "VND", None, ()),
```

### 3. Cangjie Parser (`cangjieParser.js`)

Low-level parser module for cangjie5.txt.

**Functions:**
- `parseCangjieDatabase()` - Parse file into Map
- `getCode(database, character)` - Get code for one character
- `getCodes(database, characters)` - Get codes for multiple characters
- `validateCode(database, character, expectedCode)` - Validate a code

**Usage (in code):**
```javascript
const { parseCangjieDatabase, getCode } = require('./cangjieParser');

const db = parseCangjieDatabase();
const code = getCode(db, '明');
console.log(code); // "AB"
```

## Workflow

### Adding New Characters to Lessons

1. **Look up codes:**
   ```bash
   npm run generate:chars 春夏秋冬
   ```

2. **Copy generated code** into CangjieData.res

3. **Validate:**
   ```bash
   npm run validate:codes
   ```

4. **Fix any errors** reported by validator

### Validating Existing Lessons

Run validator before committing:
```bash
npm run validate:codes
```

This ensures all codes are correct against the authoritative cangjie5.txt database.

## Database Format

`cangjie5.txt` format:
```
code<TAB>character<TAB>frequency
```

Example:
```
ab	明	1000
dd	林	500
ff	炎	200
```

- Codes are case-insensitive (converted to uppercase)
- First occurrence of each character is used
- Frequency determines priority for characters with multiple codes

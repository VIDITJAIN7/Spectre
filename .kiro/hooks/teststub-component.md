# Hook: TestStub-Component

## Description

Automatically generates test file stubs when new frontend components are created.

## Trigger

**Event**: File Created  
**File Pattern**: `apps/web/src/components/**/*.tsx`

## Context Files

- Newly created component file in `apps/web/src/components/`
- `.kiro/steering/structure.md` (for project structure reference)
- `.kiro/steering/tech.md` (for testing stack reference)

## Actions

### 1. Extract Component Information

When a new component file is created, extract:

**Component Name**: Parse the filename to get the component name
- Example: `Button.tsx` → `Button`
- Example: `UserCard.tsx` → `UserCard`
- Example: `TaskList.tsx` → `TaskList`

**Relative Path**: Determine the path relative to the components directory
- Example: `apps/web/src/components/Button.tsx` → `Button.tsx`
- Example: `apps/web/src/components/forms/Button.tsx` → `forms/Button.tsx`
- Example: `apps/web/src/components/ui/cards/UserCard.tsx` → `ui/cards/UserCard.tsx`

### 2. Determine Test File Location

Calculate the corresponding test file path:

**Pattern**: `/tests/web/components/[relative-path]/[ComponentName].test.tsx`

**Examples**:
- Component: `apps/web/src/components/Button.tsx`
  - Test: `tests/web/components/Button.test.tsx`

- Component: `apps/web/src/components/forms/LoginForm.tsx`
  - Test: `tests/web/components/forms/LoginForm.test.tsx`

- Component: `apps/web/src/components/ui/cards/UserCard.tsx`
  - Test: `tests/web/components/ui/cards/UserCard.test.tsx`

### 3. Create Directory Structure

Ensure the test directory structure exists:

1. Check if `tests/web/components/` exists, create if needed
2. Create any nested directories based on the relative path
3. Verify write permissions

### 4. Generate Test File Content

Create the test file with the following structure:

```typescript
// Auto-generated test stub - generated on [ISO timestamp]
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import [ComponentName] from '@/components/[relative-path]/[ComponentName]';

describe('[ComponentName]', () => {
  it('should render without crashing', () => {
    render(<[ComponentName] />);
    expect(screen.getByText('[ComponentName]')).toBeDefined();
  });

  it('should render correctly', () => {
    // TODO: Add specific rendering assertions
    expect(true).toBe(true);
  });

  it('should handle user interactions', () => {
    // TODO: Add interaction tests
    expect(true).toBe(true);
  });
});
```

**Variable Replacements**:
- `[ISO timestamp]` → Current timestamp in ISO 8601 format
- `[ComponentName]` → Extracted component name
- `[relative-path]` → Relative path from components directory (without `.tsx` extension)

### 5. Write Test File

Write the generated content to the test file:
- Use UTF-8 encoding
- Ensure proper line endings
- Set appropriate file permissions

## Validation

After generating the test file:

1. **Verify File Creation**: Confirm test file exists at expected path
2. **Check Syntax**: Ensure generated TypeScript is valid
3. **Verify Imports**: Confirm import paths are correct
4. **Check Directory Structure**: Verify all parent directories were created

## Expected Output

### Success Case

```
✓ Detected new component: apps/web/src/components/forms/LoginForm.tsx
✓ Extracted component name: LoginForm
✓ Determined relative path: forms/LoginForm.tsx
✓ Created directory: tests/web/components/forms/
✓ Generated test file: tests/web/components/forms/LoginForm.test.tsx
✓ Test stub ready for implementation

Next steps:
1. Open tests/web/components/forms/LoginForm.test.tsx
2. Replace TODO comments with actual test cases
3. Run tests with: npm test
```

### Nested Component Case

```
✓ Detected new component: apps/web/src/components/ui/cards/UserCard.tsx
✓ Extracted component name: UserCard
✓ Determined relative path: ui/cards/UserCard.tsx
✓ Created directory structure: tests/web/components/ui/cards/
✓ Generated test file: tests/web/components/ui/cards/UserCard.test.tsx
✓ Test stub ready for implementation
```

## Error Handling

### Component Name Extraction Errors

**Issue**: Cannot determine component name from filename
**Response**:
- Log the filename that caused the issue
- Skip test generation
- Notify user to check filename format

**Example**:
```
✗ Failed to extract component name from: apps/web/src/components/index.tsx
  Reason: Index files are not supported for automatic test generation
  Skipping test stub creation.
```

### Directory Creation Errors

**Issue**: Cannot create test directory structure
**Response**:
- Check parent directory permissions
- Report specific path that failed
- Suggest manual directory creation

**Example**:
```
✗ Failed to create directory: tests/web/components/forms/
  Error: EACCES - Permission denied
  Please check permissions for the tests/ directory.
```

### File Write Errors

**Issue**: Cannot write test file
**Response**:
- Check if file already exists (don't overwrite)
- Check write permissions
- Report specific error

**Example**:
```
⚠ Test file already exists: tests/web/components/Button.test.tsx
  Skipping generation to preserve existing tests.
  If you want to regenerate, delete the existing file first.
```

### Import Path Errors

**Issue**: Cannot determine correct import path
**Response**:
- Use fallback relative import path
- Log warning about potential import issues
- Generate file with TODO comment about import path

**Example**:
```
⚠ Generated test file with potential import path issues
  File: tests/web/components/forms/LoginForm.test.tsx
  Please verify the import path is correct:
  import LoginForm from '@/components/forms/LoginForm';
```

## Generated Test File Examples

### Simple Component (Root Level)

**Component**: `apps/web/src/components/Button.tsx`

**Generated Test**: `tests/web/components/Button.test.tsx`

```typescript
// Auto-generated test stub - generated on 2024-11-07T10:30:45.123Z
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import Button from '@/components/Button';

describe('Button', () => {
  it('should render without crashing', () => {
    render(<Button />);
    expect(screen.getByText('Button')).toBeDefined();
  });

  it('should render correctly', () => {
    // TODO: Add specific rendering assertions
    expect(true).toBe(true);
  });

  it('should handle user interactions', () => {
    // TODO: Add interaction tests
    expect(true).toBe(true);
  });
});
```

### Nested Component (Forms)

**Component**: `apps/web/src/components/forms/LoginForm.tsx`

**Generated Test**: `tests/web/components/forms/LoginForm.test.tsx`

```typescript
// Auto-generated test stub - generated on 2024-11-07T10:30:45.123Z
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import LoginForm from '@/components/forms/LoginForm';

describe('LoginForm', () => {
  it('should render without crashing', () => {
    render(<LoginForm />);
    expect(screen.getByText('LoginForm')).toBeDefined();
  });

  it('should render correctly', () => {
    // TODO: Add specific rendering assertions
    expect(true).toBe(true);
  });

  it('should handle user interactions', () => {
    // TODO: Add interaction tests
    expect(true).toBe(true);
  });
});
```

### Deeply Nested Component (UI/Cards)

**Component**: `apps/web/src/components/ui/cards/UserCard.tsx`

**Generated Test**: `tests/web/components/ui/cards/UserCard.test.tsx`

```typescript
// Auto-generated test stub - generated on 2024-11-07T10:30:45.123Z
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import UserCard from '@/components/ui/cards/UserCard';

describe('UserCard', () => {
  it('should render without crashing', () => {
    render(<UserCard />);
    expect(screen.getByText('UserCard')).toBeDefined();
  });

  it('should render correctly', () => {
    // TODO: Add specific rendering assertions
    expect(true).toBe(true);
  });

  it('should handle user interactions', () => {
    // TODO: Add interaction tests
    expect(true).toBe(true);
  });
});
```

## Implementation Guidelines

### Test Stub Purpose

The generated test stubs provide:

1. **Basic Structure**: Standard Vitest + React Testing Library setup
2. **Smoke Test**: Ensures component renders without errors
3. **TODO Placeholders**: Reminds developers to add specific tests
4. **Consistent Format**: All component tests follow the same pattern

### Developer Workflow

After a test stub is generated:

1. **Review the stub**: Open the generated test file
2. **Update imports**: Verify import paths are correct
3. **Add props**: If component requires props, add them to render calls
4. **Replace TODOs**: Implement actual test cases
5. **Run tests**: Execute `npm test` to verify

### Best Practices

**DO**:
- Keep the basic structure intact
- Add more specific test cases as needed
- Test component behavior, not implementation details
- Use meaningful test descriptions

**DON'T**:
- Delete the auto-generated comment header
- Remove the smoke test (it's valuable)
- Overwrite existing test files

## Notes

- This hook runs automatically when new `.tsx` files are created in `apps/web/src/components/`
- Existing test files are never overwritten to preserve manual test implementations
- The generated tests use Vitest and React Testing Library as specified in `.kiro/steering/tech.md`
- Import paths use the `@/components/` alias for consistency
- Developers should expand the TODO sections with actual test cases
- The smoke test (`should render without crashing`) is a good baseline but should be supplemented with more specific tests

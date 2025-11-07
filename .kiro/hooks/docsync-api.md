# Hook: DocSync-API

## Description

Automatically maintains live API documentation by updating `docs/api.md` whenever backend routes are modified.

## Trigger

**Event**: File Saved  
**File Pattern**: `apps/api/src/routes/**/*.ts`

## Context Files

- Modified route file in `apps/api/src/routes/`
- Existing `docs/api.md` (if present)
- `.kiro/steering/structure.md` (for project structure reference)
- `.kiro/steering/tech.md` (for technology stack reference)

## Actions

### 1. Parse Route File

When a route file is saved, analyze the file to identify all Express.js route definitions:

- `router.get(...)`
- `router.post(...)`
- `router.put(...)`
- `router.delete(...)`
- `router.patch(...)`

### 2. Extract Route Information

For each route definition found, extract:

**HTTP Method**: GET, POST, PUT, DELETE, PATCH

**Route Path**: The endpoint path (e.g., `/api/tasks/:id`, `/api/users`)

**JSDoc Comments**: Any JSDoc comments immediately preceding the route definition
```typescript
/**
 * Get all tasks for the current user
 * @param {string} status - Optional status filter (todo, in-progress, done)
 * @returns {Task[]} Array of task objects
 */
router.get('/api/tasks', ...)
```

**Request Body Schema**: Look for:
- Zod schema validation in the route handler
- JSDoc `@body` or `@request` tags
- Inline comments describing expected body structure

**Response Format**: Look for:
- JSDoc `@returns` or `@response` tags
- TypeScript return type annotations
- Inline comments describing response structure

**Examples**: Extract any example JSON from JSDoc comments:
```typescript
/**
 * @example
 * {
 *   "title": "Complete project",
 *   "status": "todo"
 * }
 */
```

### 3. Update API Documentation

Update or create `/docs/api.md` with the following process:

#### A. Read Existing Documentation
- If `docs/api.md` exists, read its current content
- Parse existing route entries to identify what needs updating
- Preserve any manual content (introduction, notes, etc.)

#### B. Process Each Route
For each route extracted from the saved file:

**If route already exists in documentation**:
- Update the existing entry with new information
- Preserve any manually added notes or examples
- Update the description, request body, and response format

**If route is new**:
- Create a new entry using the standard format
- Insert it in alphabetical order by endpoint path

#### C. Generate Documentation Entry

Use this markdown format for each route:

```markdown
### [METHOD] /path/to/endpoint

**Description**: [From JSDoc or "No description provided"]

**Request Body**: 
```json
[Schema or "None"]
```

**Response**: 
```json
[Format or "No documentation"]
```

**Example**:
```json
[If examples exist in JSDoc]
```
```

#### D. Maintain Structure

- Keep routes organized alphabetically by path
- Group routes by resource if possible (e.g., all `/api/tasks/*` together)
- Preserve section headers and introductory text
- Maintain consistent formatting

#### E. Add Timestamp

Add or update a timestamp comment at the top of the file:
```markdown
<!-- Last updated: 2024-11-07T10:30:45.123Z -->
```

### 4. Write Updated Documentation

Write the updated content back to `/docs/api.md`:
- Create the `docs/` directory if it doesn't exist
- Preserve file permissions
- Use UTF-8 encoding
- Ensure proper line endings

## Validation

After updating the documentation:

1. **Verify File Creation**: Confirm `docs/api.md` exists and is readable
2. **Check Markdown Syntax**: Ensure generated markdown is valid
3. **Verify Route Count**: Confirm all routes from the file are documented
4. **Check Ordering**: Verify routes are in alphabetical order
5. **Validate Timestamp**: Ensure timestamp is in ISO 8601 format

## Expected Output

### Success Case

```
✓ Parsed apps/api/src/routes/task-routes.ts
✓ Found 5 route definitions:
  - GET /api/tasks
  - POST /api/tasks
  - GET /api/tasks/:id
  - PUT /api/tasks/:id
  - DELETE /api/tasks/:id
✓ Updated docs/api.md
  - Updated 3 existing routes
  - Added 2 new routes
  - Maintained alphabetical ordering
✓ Added timestamp: 2024-11-07T10:30:45.123Z

API documentation is up to date!
```

### Partial Success Case

```
⚠ Parsed apps/api/src/routes/user-routes.ts
✓ Found 3 route definitions
⚠ Some routes missing JSDoc comments:
  - POST /api/users (no description)
  - PUT /api/users/:id (no request body schema)
✓ Updated docs/api.md with available information
✓ Added timestamp: 2024-11-07T10:30:45.123Z

Recommendation: Add JSDoc comments to routes for better documentation.
```

## Error Handling

### File Parse Errors

**Issue**: Cannot parse TypeScript file
**Response**: 
- Log the parsing error with line number
- Skip documentation update for this file
- Notify user of syntax errors

**Example**:
```
✗ Failed to parse apps/api/src/routes/task-routes.ts
  Error: Unexpected token at line 45
  Skipping documentation update.
  Please fix syntax errors and save again.
```

### Route Extraction Errors

**Issue**: Cannot identify route definitions
**Response**:
- Log warning about unrecognized patterns
- Document what was successfully extracted
- Suggest checking route definition syntax

### Documentation Write Errors

**Issue**: Cannot write to `docs/api.md`
**Response**:
- Check if `docs/` directory exists, create if needed
- Check file permissions
- Report specific error to user

**Example**:
```
✗ Failed to write docs/api.md
  Error: EACCES - Permission denied
  Please check file permissions for the docs/ directory.
```

## Documentation Format Example

```markdown
<!-- Last updated: 2024-11-07T10:30:45.123Z -->

# API Documentation

This document provides a reference for all API endpoints in the application.

## Tasks

### GET /api/tasks

**Description**: Retrieve all tasks for the current user with optional filtering

**Request Body**: None

**Query Parameters**:
```json
{
  "status": "todo | in-progress | done (optional)",
  "priority": "low | medium | high (optional)"
}
```

**Response**: 
```json
{
  "success": true,
  "data": [
    {
      "id": "string",
      "title": "string",
      "status": "string",
      "priority": "string",
      "createdAt": "string (ISO 8601)"
    }
  ]
}
```

**Example**:
```json
{
  "success": true,
  "data": [
    {
      "id": "task-123",
      "title": "Complete project documentation",
      "status": "in-progress",
      "priority": "high",
      "createdAt": "2024-11-07T10:00:00.000Z"
    }
  ]
}
```

---

### POST /api/tasks

**Description**: Create a new task

**Request Body**: 
```json
{
  "title": "string (required)",
  "description": "string (optional)",
  "priority": "low | medium | high (optional, default: medium)",
  "dueDate": "string (ISO 8601, optional)"
}
```

**Response**: 
```json
{
  "success": true,
  "data": {
    "id": "string",
    "title": "string",
    "status": "todo",
    "priority": "string",
    "createdAt": "string (ISO 8601)"
  }
}
```

**Example**:
```json
{
  "success": true,
  "data": {
    "id": "task-124",
    "title": "Review pull request",
    "status": "todo",
    "priority": "medium",
    "createdAt": "2024-11-07T10:30:45.123Z"
  }
}
```

---

### GET /api/tasks/:id

**Description**: Retrieve a specific task by ID

**Request Body**: None

**Response**: 
```json
{
  "success": true,
  "data": {
    "id": "string",
    "title": "string",
    "description": "string",
    "status": "string",
    "priority": "string",
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
  }
}
```

---

## Users

### GET /api/users/me

**Description**: Get current authenticated user profile

**Request Body**: None

**Response**: 
```json
{
  "success": true,
  "data": {
    "id": "string",
    "email": "string",
    "name": "string",
    "createdAt": "string (ISO 8601)"
  }
}
```
```

## Notes

- This hook runs automatically on every save of route files
- Documentation is generated from code, but can be manually enhanced
- Manual additions to `docs/api.md` are preserved during updates
- Routes are kept in alphabetical order for easy reference
- Missing JSDoc comments result in default placeholder text
- Consider adding comprehensive JSDoc comments to routes for better documentation

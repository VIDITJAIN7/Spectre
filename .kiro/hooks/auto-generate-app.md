# Hook: Auto-Generate App

## Description

Automatically runs the complete application generation workflow when template files are saved. This master hook executes validation, scaffolding, and boilerplate generation in sequence.

## Trigger

**Event**: File Saved  
**File Patterns**: 
- `templates/requirements.md`
- `templates/design.md`

## Workflow

This hook runs three workflows in sequence:

### 1. Validate Structure
- Scans for unreplaced placeholders
- Verifies file structure is complete
- Checks content completeness
- **If validation fails**: Stops and reports errors
- **If validation passes**: Proceeds to scaffolding

### 2. Scaffold Application
- Creates complete directory structure
- Generates configuration files
- Creates entry points
- Sets up testing infrastructure
- **If scaffolding fails**: Stops and reports errors
- **If scaffolding succeeds**: Proceeds to boilerplate generation

### 3. Generate Boilerplate
- Analyzes data models from design.md
- Generates backend code (models, routes, services)
- Generates frontend code (components, hooks, stores)
- Creates utility code (validation, helpers)
- Adds documentation comments

## Context Files

- `templates/requirements.md`
- `templates/design.md`
- `templates/tasks.md`
- `.kiro/steering/product.md`
- `.kiro/steering/structure.md`
- `.kiro/steering/tech.md`

## Expected Output

### Success Case

```
=== STEP 1: VALIDATION ===
✓ Placeholder check: All placeholders replaced (0 remaining)
✓ File structure: All required files present
✓ Content completeness: All sections properly filled

=== STEP 2: SCAFFOLDING ===
✓ Created directory structure (15 directories)
✓ Generated configuration files (6 files)
✓ Created entry points (4 files)
✓ Setup testing infrastructure (3 files)

=== STEP 3: BOILERPLATE GENERATION ===
✓ Generated Backend:
  - 3 data models (User, Task, Project)
  - 9 API routes
  - 3 service files
  - 2 middleware files

✓ Generated Frontend:
  - 3 TypeScript interfaces
  - 9 API client functions
  - 6 component stubs
  - 3 custom hooks
  - 2 store slices

✓ Generated Utilities:
  - 3 validation schemas
  - 4 helper functions

Total: 52 files generated

=== NEXT STEPS ===
1. Run 'npm install' to install dependencies
2. Review generated files in apps/ directory
3. Start development servers:
   - Frontend: npm run dev (in apps/web)
   - Backend: npm run dev (in apps/api)
4. Begin implementing TODO items in service files
```

### Validation Failure Case

```
=== STEP 1: VALIDATION ===
✗ Placeholder check: 5 unreplaced placeholders found

Unreplaced Placeholders:
  templates/requirements.md:
    - Line 15: <APP_NAME>
    - Line 23: <APP_DESCRIPTION>
  
  templates/design.md:
    - Line 67: <FRONTEND_TECH>
    - Line 89: <DATA_MODELS>

✗ Content completeness: 2 sections appear incomplete

Status: VALIDATION FAILED
Workflow stopped. Please fix the issues above and save the file again.

Next Steps:
1. Replace all <PLACEHOLDER> markers with actual values
2. Complete incomplete sections
3. Save the file to trigger workflow again
```

## Error Handling

- **Validation Errors**: Stops workflow, provides detailed error report with file locations
- **Scaffolding Errors**: Reports which directories/files failed to create
- **Boilerplate Errors**: Reports which code generation steps failed
- **Partial Success**: Shows what was successfully created before failure

## Benefits

- **One-Click Generation**: Save template file → complete app generated
- **Safe**: Validates before making changes
- **Incremental**: Each step must succeed before next step runs
- **Informative**: Detailed output shows exactly what was created
- **Error-Friendly**: Clear error messages with actionable fixes

## Notes

- This hook replaces the need to manually run three separate hooks
- Validation ensures you don't generate incomplete apps
- If you want more control, you can still run individual hooks manually
- The hook only runs when you save templates/requirements.md or templates/design.md
- Existing files are not overwritten (safe to run multiple times)

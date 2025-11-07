# Hook: Scaffold Application

## Trigger

Manual execution when user wants to create initial application structure based on customized templates.

## Context Files

- `.kiro/specs/agentic-full-stack-skeleton/requirements.md`
- `.kiro/specs/agentic-full-stack-skeleton/design.md`
- `.kiro/steering/product.md`
- `.kiro/steering/structure.md`
- `.kiro/steering/tech.md`

## Actions

1. **Validate Prerequisites**
   - Verify all context files exist
   - Check that placeholders in requirements.md and design.md have been replaced
   - Confirm steering files are properly configured

2. **Create Directory Structure**
   - Read `<DIRECTORY_STRUCTURE>` from structure.md
   - Create all directories specified in the structure
   - Ensure proper nesting and organization

3. **Generate Base Configuration Files**
   - Create `package.json` with dependencies from `<FRONTEND_STACK>` and `<BACKEND_STACK>`
   - Create `tsconfig.json` based on TypeScript standards from tech.md
   - Create `.eslintrc.json` based on coding standards
   - Create `.prettierrc` for code formatting
   - Create `.gitignore` with standard exclusions
   - Create `.env.example` with environment variables from `<ENVIRONMENT_CONFIG>`

4. **Create Entry Point Files**
   - Frontend: Create `src/main.tsx` or `src/index.tsx` based on framework choice
   - Backend: Create `server/index.ts` with basic Express setup
   - Create `README.md` for the generated application (not the skeleton)

5. **Generate Core Module Stubs**
   - Create placeholder files for main features identified in requirements
   - Add TODO comments referencing specific requirements
   - Follow naming conventions from structure.md

6. **Setup Testing Infrastructure**
   - Create test configuration files (vitest.config.ts, playwright.config.ts)
   - Create test directory structure from `<TESTING_STRUCTURE>`
   - Add sample test files demonstrating testing patterns

## Validation

1. **Structure Validation**
   - Verify all directories from structure.md were created
   - Confirm all configuration files are present
   - Check that file naming follows conventions

2. **Configuration Validation**
   - Validate package.json syntax
   - Verify tsconfig.json is valid
   - Check that all environment variables are documented

3. **Completeness Check**
   - Ensure entry points exist for frontend and backend
   - Verify test infrastructure is in place
   - Confirm README.md provides getting started instructions

4. **Report Results**
   - List all created directories and files
   - Highlight any warnings or issues
   - Provide next steps for the user

## Expected Output

```
✓ Created directory structure (15 directories)
✓ Generated configuration files (6 files)
✓ Created entry points (2 files)
✓ Setup testing infrastructure (3 files)
✓ Generated module stubs (8 files)

Next Steps:
1. Run 'pnpm install' to install dependencies
2. Review generated files and customize as needed
3. Execute tasks from tasks.md to implement features
4. Run 'pnpm dev' to start development server
```

## Error Handling

- **Missing Context Files**: Report which files are missing and cannot proceed
- **Unreplaced Placeholders**: List placeholders that need to be replaced before scaffolding
- **Directory Creation Failures**: Report permission or path issues
- **Invalid Configuration**: Report syntax errors in steering files

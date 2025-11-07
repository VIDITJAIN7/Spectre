# Design Document

## Overview

The Agentic Full-Stack Skeleton is a template-based code generation system that produces complete, well-architected full-stack TypeScript applications from high-level user prompts. The system consists of three main components:

1. **Template Repository**: A collection of template files with placeholder markers
2. **Generation Engine**: Logic that processes templates and replaces placeholders with user-specific content
3. **Validation System**: Checks that ensure generated applications are complete and functional

The skeleton is designed to be used within the Kiro IDE, leveraging its spec-driven development workflow and agent capabilities.

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Agentic Full-Stack Skeleton               │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐      ┌──────────────┐      ┌───────────┐ │
│  │   Template   │      │  Generation  │      │Validation │ │
│  │  Repository  │─────▶│    Engine    │─────▶│  System   │ │
│  └──────────────┘      └──────────────┘      └───────────┘ │
│         │                      │                     │       │
│         │                      │                     │       │
│         ▼                      ▼                     ▼       │
│  ┌──────────────────────────────────────────────────────┐  │
│  │           Generated Application Output                │  │
│  │  ┌────────┐  ┌────────┐  ┌────────┐  ┌──────────┐   │  │
│  │  │ .kiro/ │  │ apps/  │  │ docs/  │  │ tests/   │   │  │
│  │  └────────┘  └────────┘  └────────┘  └──────────┘   │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Component Interaction Flow

1. User provides app concept via Kiro spec workflow
2. Template Repository provides base files with placeholders
3. Generation Engine processes templates and replaces placeholders
4. Validation System verifies completeness
5. Generated Application is written to workspace

## Components and Interfaces

### 1. Template Repository

**Purpose**: Store and organize all template files that form the basis of generated applications.

**Structure**:
```
templates/
├── apps/
│   ├── web/
│   │   ├── src/
│   │   │   ├── components/
│   │   │   │   └── App.tsx.template
│   │   │   ├── pages/
│   │   │   ├── lib/
│   │   │   │   └── store.ts.template
│   │   │   └── main.tsx.template
│   │   ├── index.html.template
│   │   ├── package.json.template
│   │   ├── tsconfig.json.template
│   │   └── vite.config.ts.template
│   └── api/
│       └── src/
│           ├── routes/
│           │   └── example-routes.ts.template
│           ├── services/
│           │   └── example-service.ts.template
│           ├── data/
│           │   └── example-data.json.template
│           └── server.ts.template
├── kiro/
│   ├── steering/
│   │   ├── product.md.template
│   │   ├── structure.md.template
│   │   └── tech.md.template
│   └── hooks/
│       ├── doc-generator.json.template
│       └── test-stub-generator.json.template
├── docs/
│   ├── api.md.template
│   └── components.md.template
├── tests/
│   ├── web/
│   │   └── example.test.tsx.template
│   └── api/
│       └── example.test.ts.template
├── README.md.template
└── package.json.template (root)
```

**Placeholder Convention**:
- Use angle bracket notation: `<PLACEHOLDER_NAME>`
- Common placeholders:
  - `<APP_NAME>`: Application name (kebab-case)
  - `<APP_TITLE>`: Application title (Title Case)
  - `<APP_DESCRIPTION>`: Brief description
  - `<CORE_FEATURES>`: Comma-separated feature list
  - `<USER_STORIES>`: Formatted user story list
  - `<COMPONENT_NAME>`: Component name (PascalCase)
  - `<SERVICE_NAME>`: Service name (kebab-case)
  - `<ROUTE_PATH>`: API route path

**Template File Format**:
```typescript
// Example: App.tsx.template
import React from 'react';

function <COMPONENT_NAME>() {
  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white shadow">
        <h1 className="text-3xl font-bold text-gray-900">
          <APP_TITLE>
        </h1>
      </header>
      <main className="container mx-auto px-4 py-8">
        <p className="text-gray-600"><APP_DESCRIPTION></p>
      </main>
    </div>
  );
}

export default <COMPONENT_NAME>;
```

### 2. Generation Engine

**Purpose**: Process template files, replace placeholders, and write generated files to the workspace.

**Core Interface**:
```typescript
interface GenerationEngine {
  // Load all templates from the template repository
  loadTemplates(): Promise<TemplateCollection>;
  
  // Process a single template with provided context
  processTemplate(template: Template, context: GenerationContext): string;
  
  // Generate complete application structure
  generateApplication(context: GenerationContext): Promise<GeneratedApp>;
  
  // Write generated files to workspace
  writeToWorkspace(app: GeneratedApp, targetPath: string): Promise<void>;
}

interface GenerationContext {
  appName: string;
  appTitle: string;
  appDescription: string;
  coreFeatures: string[];
  userStories: UserStory[];
  customPlaceholders?: Record<string, string>;
}

interface Template {
  path: string;           // Relative path in generated app
  content: string;        // Template content with placeholders
  type: 'file' | 'directory';
}

interface GeneratedApp {
  files: GeneratedFile[];
  directories: string[];
}

interface GeneratedFile {
  path: string;
  content: string;
}
```

**Processing Algorithm**:
1. Parse user input to extract placeholder values
2. Load all template files from repository
3. For each template:
   - Replace all placeholders with context values
   - Apply naming conventions (PascalCase, kebab-case, etc.)
   - Handle conditional sections if present
4. Organize generated files by directory structure
5. Write files to workspace in correct order (directories first)

**Placeholder Replacement Logic**:
```typescript
function replacePlaceholders(content: string, context: GenerationContext): string {
  let result = content;
  
  // Direct replacements
  result = result.replace(/<APP_NAME>/g, context.appName);
  result = result.replace(/<APP_TITLE>/g, context.appTitle);
  result = result.replace(/<APP_DESCRIPTION>/g, context.appDescription);
  
  // List replacements
  result = result.replace(/<CORE_FEATURES>/g, 
    context.coreFeatures.join(', '));
  
  // Complex replacements (user stories)
  result = result.replace(/<USER_STORIES>/g, 
    formatUserStories(context.userStories));
  
  // Custom placeholders
  if (context.customPlaceholders) {
    for (const [key, value] of Object.entries(context.customPlaceholders)) {
      const pattern = new RegExp(`<${key}>`, 'g');
      result = result.replace(pattern, value);
    }
  }
  
  return result;
}
```

### 3. Validation System

**Purpose**: Ensure generated applications are complete, syntactically correct, and ready for development.

**Validation Interface**:
```typescript
interface ValidationSystem {
  // Validate complete generated application
  validate(app: GeneratedApp): ValidationResult;
  
  // Check for required files
  validateStructure(app: GeneratedApp): StructureValidation;
  
  // Check for syntax errors in generated code
  validateSyntax(app: GeneratedApp): SyntaxValidation;
  
  // Check for missing placeholders
  validatePlaceholders(app: GeneratedApp): PlaceholderValidation;
}

interface ValidationResult {
  isValid: boolean;
  errors: ValidationError[];
  warnings: ValidationWarning[];
}

interface ValidationError {
  file: string;
  message: string;
  severity: 'error' | 'warning';
}
```

**Validation Checks**:
1. **Structure Validation**: Verify all required directories and files exist
2. **Syntax Validation**: Parse TypeScript/JSON files to check for syntax errors
3. **Placeholder Validation**: Ensure no unreplaced placeholders remain
4. **Dependency Validation**: Check that package.json dependencies are consistent
5. **Configuration Validation**: Verify tsconfig.json and vite.config.ts are valid

### 4. Steering File Generator

**Purpose**: Create AI guidance files that influence code generation behavior in the Kiro IDE.

**Steering File Templates**:

**product.md.template**:
```markdown
# Product Vision: <APP_TITLE>

## Overview

<APP_DESCRIPTION>

## Target Users

<TARGET_USERS>

## Value Proposition

<VALUE_PROPOSITION>

## Design Principles

- **Lean**: Minimal boilerplate, maximum functionality
- **Clear**: Obvious project structure and code organization
- **Local**: Complete development environment without external services
```

**structure.md.template**: Contains the complete directory structure with actual app-specific paths

**tech.md.template**: Contains the technology stack (TypeScript, React, Express, Vite, Tailwind, Zustand, Vitest)

### 5. Agent Hook Generator

**Purpose**: Create pre-configured agent hooks for documentation and test generation.

**Hook Definitions**:

**Documentation Generator Hook**:
```json
{
  "name": "Update Documentation",
  "trigger": "onSave",
  "filePattern": "**/*.{ts,tsx}",
  "prompt": "Update the documentation in docs/ to reflect changes in the saved file. For components, update docs/components.md. For API routes, update docs/api.md.",
  "autoRun": true
}
```

**Test Stub Generator Hook**:
```json
{
  "name": "Generate Test Stub",
  "trigger": "manual",
  "prompt": "Create a test stub for the currently open file in the appropriate tests/ subdirectory. Include basic test structure with describe blocks and example test cases.",
  "autoRun": false
}
```

## Data Models

### Template Metadata

```typescript
interface TemplateMetadata {
  version: string;
  lastUpdated: string;
  requiredPlaceholders: string[];
  optionalPlaceholders: string[];
  targetFramework: 'react' | 'vue' | 'angular';
  targetBackend: 'express' | 'fastify' | 'nest';
}
```

### Generation Configuration

```typescript
interface GenerationConfig {
  templateVersion: string;
  outputPath: string;
  overwriteExisting: boolean;
  includeTests: boolean;
  includeDocumentation: boolean;
  includeSteering: boolean;
  includeHooks: boolean;
}
```

### User Input Schema

```typescript
interface UserInput {
  appName: string;              // Required: kebab-case name
  appTitle: string;             // Required: Display name
  appDescription: string;       // Required: Brief description
  coreFeatures: string[];       // Required: List of features
  userStories: UserStory[];     // Optional: Detailed user stories
  targetUsers: string;          // Optional: Target audience
  valueProp: string;            // Optional: Value proposition
  customTech?: TechOverrides;   // Optional: Technology overrides
}

interface UserStory {
  role: string;
  goal: string;
  benefit: string;
}

interface TechOverrides {
  frontend?: string;
  backend?: string;
  styling?: string;
  stateManagement?: string;
}
```

## Extension Points

### 1. Template Customization

Developers can add new templates or modify existing ones by:
- Adding new `.template` files to the templates/ directory
- Defining new placeholder markers in template content
- Updating the TemplateMetadata to include new placeholders

### 2. Generation Logic Extension

The Generation Engine can be extended to support:
- Conditional template sections (e.g., include auth only if requested)
- Multi-variant templates (e.g., different component styles)
- Custom transformation functions for placeholder values

### 3. Validation Rule Addition

New validation rules can be added by:
- Implementing new validator functions
- Registering validators with the ValidationSystem
- Defining custom error messages and severity levels

### 4. Hook Template Expansion

Additional agent hooks can be created for:
- Code formatting on save
- Dependency update checks
- Security vulnerability scanning
- Performance optimization suggestions

## Error Handling

### Generation Errors

**Missing Required Placeholder**:
- Error: "Required placeholder <PLACEHOLDER_NAME> not provided"
- Resolution: Prompt user for missing value
- Fallback: Use default value if available

**Template File Not Found**:
- Error: "Template file not found: <path>"
- Resolution: Check template repository integrity
- Fallback: Skip optional templates, fail for required templates

**Invalid User Input**:
- Error: "Invalid app name format (must be kebab-case)"
- Resolution: Validate input before generation
- Fallback: Auto-convert to valid format with user confirmation

### Validation Errors

**Syntax Error in Generated Code**:
- Error: "Syntax error in <file>: <message>"
- Resolution: Review template for errors
- Fallback: Generate with warning, allow manual fix

**Missing Required File**:
- Error: "Required file missing: <path>"
- Resolution: Check template repository completeness
- Fallback: Regenerate from template

**Unreplaced Placeholder**:
- Error: "Unreplaced placeholder found: <PLACEHOLDER_NAME> in <file>"
- Resolution: Add placeholder to context
- Fallback: Replace with default value or empty string

### File System Errors

**Write Permission Denied**:
- Error: "Cannot write to <path>: Permission denied"
- Resolution: Check workspace permissions
- Fallback: Prompt user to resolve permissions

**Directory Already Exists**:
- Error: "Output directory already exists: <path>"
- Resolution: Prompt user to overwrite or choose new location
- Fallback: Merge with existing structure (careful mode)

## Testing Strategy

### Unit Tests

**Template Processing**:
- Test placeholder replacement with various contexts
- Test edge cases (missing placeholders, special characters)
- Test naming convention transformations

**Validation Logic**:
- Test structure validation with complete and incomplete apps
- Test syntax validation with valid and invalid code
- Test placeholder detection in generated files

**File Operations**:
- Test template loading from repository
- Test file writing to workspace
- Test directory creation and organization

### Integration Tests

**End-to-End Generation**:
- Test complete application generation from user input
- Test generated app can be built and run
- Test generated tests can be executed

**Validation Pipeline**:
- Test validation catches all error types
- Test validation provides actionable error messages
- Test validation warnings don't block generation

### Validation Tests

**Generated Application Quality**:
- Verify generated app follows structure.md conventions
- Verify generated app uses technologies from tech.md
- Verify generated app includes all required files
- Verify generated code has no syntax errors
- Verify generated package.json has correct dependencies

**Template Integrity**:
- Verify all templates have valid syntax
- Verify all templates use documented placeholders
- Verify templates produce valid code when processed

### Manual Testing

**User Experience**:
- Test generation workflow in Kiro IDE
- Test agent hooks trigger correctly
- Test documentation generation produces useful output
- Test generated apps work for different use cases (productivity tool, dashboard, etc.)

## Performance Considerations

### Template Loading

- Cache loaded templates in memory during generation session
- Use lazy loading for optional templates
- Implement template preloading for common generation patterns

### File Writing

- Batch file write operations to reduce I/O
- Write files in parallel where possible
- Use streaming for large generated files

### Validation

- Run syntax validation in parallel for multiple files
- Cache validation results for unchanged files
- Implement incremental validation for iterative generation

## Security Considerations

### Input Sanitization

- Validate all user input before processing
- Escape special characters in placeholder values
- Prevent path traversal in file names

### Template Safety

- Restrict template file access to templates/ directory
- Validate template content before processing
- Prevent code injection through placeholder values

### Generated Code Safety

- Ensure generated code follows security best practices
- Avoid generating hardcoded secrets or credentials
- Include security-focused comments in generated code

## Future Enhancements

### Multi-Language Support

- Add templates for Python/Flask backend
- Add templates for Vue.js frontend
- Support polyglot applications

### Advanced Generation Features

- Conditional template sections based on feature flags
- Multi-variant generation (generate multiple versions)
- Incremental generation (add features to existing app)

### AI-Powered Enhancements

- Use LLM to generate custom components based on descriptions
- Auto-generate realistic sample data for JSON files
- Suggest architectural improvements based on app description

### Collaboration Features

- Share custom templates with team
- Version control for template repository
- Template marketplace for community contributions

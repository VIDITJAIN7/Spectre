# Design Document: Agentic Full-Stack Skeleton

## Overview

The Agentic Full-Stack Skeleton is a meta-framework that generates application scaffolding through a placeholder-driven template system. It consists of four primary components: template files with standardized placeholders, steering files that guide AI agent behavior, agent hooks for automation, and documentation that explains the customization process.

The skeleton operates as a static file generator with no runtime dependencies. Users customize the skeleton by replacing placeholder markers with application-specific values, then use AI agents to generate the actual application code based on the customized templates.

## Architecture

### System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  Agentic Full-Stack Skeleton            │
│                                                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │   Template   │  │   Steering   │  │    Agent     │ │
│  │    Files     │  │    Files     │  │    Hooks     │ │
│  │              │  │              │  │              │ │
│  │ requirements │  │  product.md  │  │  scaffold/   │ │
│  │ design.md    │  │  structure   │  │  validate/   │ │
│  │ tasks.md     │  │  tech.md     │  │  generate/   │ │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘ │
│         │                 │                 │         │
│         └─────────────────┼─────────────────┘         │
│                           │                           │
│                    ┌──────▼───────┐                   │
│                    │  Placeholder │                   │
│                    │    Engine    │                   │
│                    └──────┬───────┘                   │
│                           │                           │
│                    ┌──────▼───────┐                   │
│                    │  Generated   │                   │
│                    │  Application │                   │
│                    │   Scaffold   │                   │
│                    └──────────────┘                   │
└─────────────────────────────────────────────────────────┘
```

### Design Principles

1. **Placeholder-Driven**: All customization happens through standardized placeholder replacement
2. **Layer Separation**: Clear boundaries between template, steering, and automation layers
3. **AI-First**: Designed for AI agent consumption and generation
4. **Local-Only**: No external dependencies or network requirements
5. **Composable**: Components can be used independently or together

## Components and Interfaces

### 1. Template Files Component

**Purpose**: Provides master blueprint files with placeholder markers for customization.

**Structure**:
```
.kiro/specs/agentic-full-stack-skeleton/
├── requirements.md (template)
├── design.md (template)
└── tasks.md (template)
```

**Placeholder Syntax**:
- Format: `<PLACEHOLDER_NAME>`
- Examples: `<APP_NAME>`, `<APP_DESCRIPTION>`, `<CORE_FEATURES>`
- Naming: SCREAMING_SNAKE_CASE for visibility

**Template Sections**:

**requirements.md Template**:
- Introduction with `<APP_DESCRIPTION>` placeholder
- Glossary with `<DOMAIN_TERMS>` placeholder
- User stories with `<USER_STORIES>` placeholder array
- Acceptance criteria with `<ACCEPTANCE_CRITERIA>` placeholders

**design.md Template**:
- Architecture Overview with `<ARCHITECTURE_PATTERN>` placeholder
- Frontend Layer with `<FRONTEND_TECH>` and `<UI_COMPONENTS>` placeholders
- Backend Layer with `<BACKEND_TECH>` and `<API_PATTERN>` placeholders
- Data Layer with `<DATABASE_TYPE>` and `<DATA_MODELS>` placeholders
- Extension Points with `<CUSTOM_MODULES>` placeholder

**tasks.md Template**:
- Implementation steps with `<TASK_DESCRIPTIONS>` placeholders
- Requirement references with `<REQ_REFS>` placeholders
- Optional task markers for testing and documentation

### 2. Steering Files Component

**Purpose**: Guides AI agent behavior during code generation with project-specific context.

**Structure**:
```
.kiro/steering/
├── product.md
├── structure.md
└── tech.md
```

**product.md Interface**:
```markdown
# Product Vision

## Vision
<PRODUCT_VISION>

## Target Users
<TARGET_USERS>

## Value Proposition
<VALUE_PROPOSITION>

## Core Principles
<CORE_PRINCIPLES>
```

**structure.md Interface**:
```markdown
# Project Structure

## Directory Layout
<DIRECTORY_STRUCTURE>

## Module Organization
<MODULE_PATTERNS>

## File Naming Conventions
<NAMING_CONVENTIONS>
```

**tech.md Interface**:
```markdown
# Technology Stack

## Frontend
<FRONTEND_STACK>

## Backend
<BACKEND_STACK>

## Data Layer
<DATA_STACK>

## Development Tools
<DEV_TOOLS>

## Coding Standards
<CODING_STANDARDS>
```

### 3. Agent Hooks Component

**Purpose**: Provides pre-packaged automation for common development workflows.

**Structure**:
```
.kiro/hooks/
├── scaffold-app.md
├── validate-structure.md
└── generate-boilerplate.md
```

**Hook Interface Pattern**:
```markdown
# Hook: <HOOK_NAME>

## Trigger
<TRIGGER_CONDITION>

## Context Files
- requirements.md
- design.md
- .kiro/steering/*.md

## Actions
<HOOK_ACTIONS>

## Validation
<VALIDATION_STEPS>
```

**Hook Types**:

1. **scaffold-app**: Creates initial directory structure and base files
2. **validate-structure**: Verifies all placeholders are replaced and structure is valid
3. **generate-boilerplate**: Creates common code patterns based on design

### 4. Documentation Component

**Purpose**: Explains skeleton usage and customization process.

**Structure**:
```
README.md (root level)
```

**Content Sections**:
- Quick Start Guide
- Placeholder Reference Table
- Customization Workflow
- Example Use Cases
- Troubleshooting

## Data Models

### Placeholder Model

```typescript
interface Placeholder {
  name: string;              // e.g., "APP_NAME"
  syntax: string;            // e.g., "<APP_NAME>"
  description: string;       // Purpose of the placeholder
  location: string[];        // Files where it appears
  exampleValue: string;      // Sample replacement value
  required: boolean;         // Must be replaced before generation
}
```

### Template Model

```typescript
interface Template {
  filePath: string;          // Path to template file
  content: string;           // Template content with placeholders
  placeholders: Placeholder[]; // Placeholders in this template
  dependencies: string[];    // Other templates this depends on
}
```

### Steering File Model

```typescript
interface SteeringFile {
  name: string;              // e.g., "product", "structure", "tech"
  path: string;              // Path in .kiro/steering/
  content: string;           // File content with placeholders
  inclusion: 'always' | 'conditional' | 'manual';
  purpose: string;           // What this file guides
}
```

### Agent Hook Model

```typescript
interface AgentHook {
  name: string;              // Hook identifier
  trigger: string;           // When to execute
  contextFiles: string[];    // Files to read for context
  actions: string[];         // Steps to perform
  validation: string[];      // How to verify success
}
```

## Error Handling

### Placeholder Validation

**Missing Placeholders**:
- Detection: Scan all template files for unreplaced `<PLACEHOLDER>` syntax
- Response: Generate list of missing placeholders with locations
- Recovery: Provide default values or prompt for user input

**Invalid Placeholder Values**:
- Detection: Validate replaced values against expected patterns
- Response: Report validation errors with specific issues
- Recovery: Suggest corrections or alternative values

### File System Errors

**Missing Directories**:
- Detection: Check for required directory structure
- Response: List missing directories
- Recovery: Create missing directories automatically

**File Access Errors**:
- Detection: Attempt to read/write template files
- Response: Report permission or path issues
- Recovery: Suggest alternative locations or permission fixes

### Agent Hook Errors

**Hook Execution Failures**:
- Detection: Monitor hook execution status
- Response: Log error details and context
- Recovery: Provide manual steps to complete hook actions

**Context File Missing**:
- Detection: Verify all context files exist before hook execution
- Response: List missing context files
- Recovery: Skip hook or use partial context

## Testing Strategy

### Template Validation Tests

**Objective**: Verify all template files contain valid placeholder syntax and structure.

**Approach**:
1. Parse each template file
2. Extract all placeholder markers
3. Verify placeholder naming conventions
4. Check for duplicate placeholders
5. Validate template structure (sections, formatting)

**Success Criteria**:
- All placeholders follow `<NAME>` syntax
- No duplicate placeholder names within same file
- All required sections present in each template

### Placeholder Replacement Tests

**Objective**: Ensure placeholder replacement produces valid output files.

**Approach**:
1. Create test cases with sample placeholder values
2. Replace placeholders in template copies
3. Verify no unreplaced placeholders remain
4. Validate output file structure
5. Check for syntax errors in generated content

**Success Criteria**:
- All placeholders successfully replaced
- Generated files are syntactically valid
- No broken references or malformed content

### Steering File Integration Tests

**Objective**: Verify steering files are properly formatted and accessible.

**Approach**:
1. Check steering directory structure
2. Validate each steering file format
3. Verify placeholder consistency across steering files
4. Test file inclusion patterns

**Success Criteria**:
- All steering files present in correct locations
- Placeholders consistent with template files
- Files readable by Kiro agent system

### Agent Hook Validation Tests

**Objective**: Ensure agent hooks can execute successfully.

**Approach**:
1. Verify hook file format and structure
2. Check context file references are valid
3. Validate action steps are clear and executable
4. Test hook trigger conditions

**Success Criteria**:
- Hook files follow standard format
- All referenced context files exist
- Actions are specific and actionable
- Triggers are well-defined

### End-to-End Skeleton Usage Tests

**Objective**: Validate complete workflow from skeleton to generated application.

**Approach**:
1. Start with fresh skeleton copy
2. Replace all placeholders with test values
3. Execute agent hooks in sequence
4. Verify generated application structure
5. Check for completeness and consistency

**Success Criteria**:
- All placeholders successfully replaced
- Agent hooks execute without errors
- Generated structure matches design
- No missing or orphaned files

## Extension Points

### Custom Template Sections

**Location**: Within template files between standard sections
**Purpose**: Allow users to add domain-specific sections
**Implementation**: Use `<!-- CUSTOM_SECTION_START -->` and `<!-- CUSTOM_SECTION_END -->` markers

### Additional Steering Files

**Location**: `.kiro/steering/` directory
**Purpose**: Add project-specific guidance beyond product/structure/tech
**Implementation**: Create new `.md` files following steering file interface pattern

### Custom Agent Hooks

**Location**: `.kiro/hooks/` directory
**Purpose**: Automate project-specific workflows
**Implementation**: Create new hook files following agent hook interface pattern

### Technology Stack Variations

**Location**: `tech.md` steering file
**Purpose**: Support different technology choices
**Implementation**: Provide multiple placeholder value sets for common stacks

### Architecture Pattern Alternatives

**Location**: `design.md` template
**Purpose**: Support different architectural approaches
**Implementation**: Include commented alternative patterns with selection placeholders

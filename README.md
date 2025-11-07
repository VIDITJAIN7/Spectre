# Agentic Full-Stack Skeleton

A generative template system for rapid prototyping of full-stack applications. This "Founder's Factory" tool provides a master blueprint with placeholder-driven customization, enabling you to quickly scaffold new applications with consistent architecture patterns, steering files, and agent hooks.

## What Is This?

The Agentic Full-Stack Skeleton is NOT a functional application - it's a meta-framework for generating other applications through AI-assisted development. Think of it as a smart template that guides AI agents to build exactly what you need.

## Quick Start

1. **Customize the Templates**: Replace placeholder markers in template files with your application-specific values
2. **Configure Steering Files**: Update `.kiro/steering/` files to guide AI agent behavior
3. **Run Agent Hooks**: Execute `.kiro/hooks/` to automate scaffolding and code generation
4. **Build Your App**: Let AI agents implement your customized design

## Core Components

### 1. Template Files (`templates/`)

- **requirements-template.md**: Master template for defining application requirements with user stories
- **design-template.md**: Master template for specifying architecture, layers, and technical approach
- **tasks-template.md**: Master template for breaking down implementation into actionable coding tasks

Copy these templates to start a new project and replace all `<PLACEHOLDER>` markers with your application-specific values.

### 2. Steering Files (`.kiro/steering/`)

Guide AI agent behavior during code generation:

- **product.md**: Product vision, target users, value proposition
- **structure.md**: Directory layout, module organization, naming conventions
- **tech.md**: Technology stack, coding standards, development tools

### 3. Agent Hooks (`.kiro/hooks/`)

Pre-packaged automation for common workflows:

- **scaffold-app.md**: Create initial directory structure and base files
- **validate-structure.md**: Verify placeholders are replaced and structure is valid
- **generate-boilerplate.md**: Create common code patterns based on design

## Placeholder Reference

All placeholders follow the `<PLACEHOLDER_NAME>` format. Replace these with your application-specific values:

| Placeholder | Purpose | Example Value |
|------------|---------|---------------|
| `<APP_NAME>` | Application name | "TaskFlow Pro" |
| `<APP_DESCRIPTION>` | Brief description | "A collaborative task management platform" |
| `<CORE_FEATURES>` | Key features list | "Real-time collaboration, task assignments, notifications" |
| `<USER_STORIES>` | User story descriptions | "As a team lead, I want to assign tasks..." |
| `<DOMAIN_TERMS>` | Domain-specific glossary | "Sprint: A 2-week development cycle" |
| `<ARCHITECTURE_PATTERN>` | Architecture style | "Microservices with event-driven communication" |
| `<FRONTEND_TECH>` | Frontend stack | "React 18, TypeScript, Tailwind CSS" |
| `<BACKEND_TECH>` | Backend stack | "Node.js, Express, PostgreSQL" |
| `<DATABASE_TYPE>` | Database choice | "PostgreSQL with Prisma ORM" |
| `<DATA_MODELS>` | Core data entities | "User, Task, Project, Team" |
| `<CUSTOM_MODULES>` | Extension modules | "Analytics, Reporting, Integrations" |
| `<PRODUCT_VISION>` | Product vision statement | "Simplify team collaboration through intelligent task management" |
| `<TARGET_USERS>` | Target audience | "Small to medium development teams (5-50 people)" |
| `<VALUE_PROPOSITION>` | Unique value | "AI-powered task prioritization and workload balancing" |
| `<CORE_PRINCIPLES>` | Design principles | "Simplicity, Speed, Collaboration" |
| `<DIRECTORY_STRUCTURE>` | Folder layout | "src/components, src/services, src/models" |
| `<MODULE_PATTERNS>` | Code organization | "Feature-based modules with clear boundaries" |
| `<NAMING_CONVENTIONS>` | File naming rules | "kebab-case for files, PascalCase for components" |
| `<FRONTEND_STACK>` | Frontend technologies | "React, TypeScript, Vite, React Query" |
| `<BACKEND_STACK>` | Backend technologies | "Node.js, Express, TypeScript, Prisma" |
| `<DATA_STACK>` | Data technologies | "PostgreSQL, Redis for caching" |
| `<DEV_TOOLS>` | Development tools | "ESLint, Prettier, Vitest, Playwright" |
| `<CODING_STANDARDS>` | Code style rules | "Airbnb style guide, functional components" |
| `<TASK_DESCRIPTIONS>` | Implementation tasks | "Implement user authentication service" |
| `<REQ_REFS>` | Requirement references | "Requirements: 1.1, 2.3, 4.2" |

## Customization Workflow

### Step 1: Define Your Application Concept

Start by identifying what you want to build:
- What problem does it solve?
- Who are the users?
- What are the core features?

### Step 2: Copy Template Files

Copy the template files to your project:
```
cp templates/requirements-template.md .kiro/specs/my-app/requirements.md
cp templates/design-template.md .kiro/specs/my-app/design.md
cp templates/tasks-template.md .kiro/specs/my-app/tasks.md
```

### Step 3: Customize Requirements Template

Open `.kiro/specs/my-app/requirements.md` and replace:
- `<APP_NAME>` with your application name
- `<APP_DESCRIPTION>` with a clear description
- `<USER_STORIES>` with your specific user stories
- `<DOMAIN_TERMS>` with domain-specific terminology
- `<FEATURE_NAME_X>` with your feature names
- `<ACCEPTANCE_CRITERION_X_Y>` with specific acceptance criteria

### Step 4: Customize Design Template

Open `.kiro/specs/my-app/design.md` and replace:
- `<ARCHITECTURE_PATTERN>` with your chosen architecture
- `<FRONTEND_TECH>`, `<BACKEND_TECH>`, `<DATABASE_TYPE>` with your tech stack
- `<DATA_MODELS>` with your core entities
- `<CUSTOM_MODULES>` with extension points

### Step 5: Customize Tasks Template

Open `.kiro/specs/my-app/tasks.md` and replace:
- `<APP_NAME>` with your application name
- `<MODEL_X>` with your data model names
- `<RESOURCE_X>` with your API resource names
- `<FEATURE_X>` with your feature names
- `<REQ_REFS>` with specific requirement references
- `<ADVANCED_FEATURE_X>` with advanced features you plan to build

### Step 6: Configure Steering Files

Update files in `.kiro/steering/`:

**product.md**: Define your product vision and target users
**structure.md**: Specify your directory structure and organization
**tech.md**: Detail your technology choices and coding standards

### Step 7: Validate Placeholders

Run the validation hook to ensure all placeholders are replaced:
```
Execute: .kiro/hooks/validate-structure.md
```

### Step 8: Generate Application Scaffold

Run the scaffold hook to create your application structure:
```
Execute: .kiro/hooks/scaffold-app.md
```

### Step 9: Generate Boilerplate Code

Run the boilerplate hook to create common code patterns:
```
Execute: .kiro/hooks/generate-boilerplate.md
```

### Step 10: Implement Tasks

Open `.kiro/specs/my-app/tasks.md` and execute tasks one by one using Kiro's task execution feature.

## Example Use Case: Task Management App

Here's how you'd customize the skeleton for a task management application:

**requirements-template.md** → **requirements.md**:
```markdown
<APP_NAME> → "TaskFlow Pro"
<APP_DESCRIPTION> → "A collaborative task management platform for development teams"
<USER_STORY_1> → "As a team lead, I want to create and assign tasks..."
<FEATURE_NAME_1> → "Task Management"
```

**design-template.md** → **design.md**:
```markdown
<ARCHITECTURE_PATTERN> → "Client-server with RESTful API"
<FRONTEND_TECH> → "React 18, TypeScript, Tailwind CSS"
<BACKEND_TECH> → "Node.js, Express, TypeScript"
<DATABASE_TYPE> → "PostgreSQL with Prisma ORM"
<DATA_MODELS> → "User, Task, Project, Team, Comment"
```

**product.md**:
```markdown
<PRODUCT_VISION> → "Simplify team collaboration through intelligent task management"
<TARGET_USERS> → "Development teams of 5-50 people"
<VALUE_PROPOSITION> → "AI-powered task prioritization and workload balancing"
```

## How It Works

```
┌─────────────────────────────────────────────────────────┐
│              Agentic Full-Stack Skeleton                │
│                                                         │
│  1. You customize templates with placeholders          │
│  2. Steering files guide AI agent behavior             │
│  3. Agent hooks automate scaffolding                   │
│  4. AI agents implement your design                    │
│  5. You get a working application                      │
└─────────────────────────────────────────────────────────┘
```

## Relationship Between Components

- **Requirements** define WHAT you're building (features, user needs)
- **Design** defines HOW it's structured (architecture, layers, patterns)
- **Tasks** define the STEPS to implement (actionable coding tasks)
- **Steering Files** guide AI BEHAVIOR (standards, conventions, principles)
- **Agent Hooks** AUTOMATE workflows (scaffolding, validation, generation)

## Local-Only Development

This skeleton operates entirely locally:
- No external API calls required
- No database setup needed for template generation
- No network connectivity required
- All files generated using local file system operations

Perfect for rapid prototyping without infrastructure overhead.

## Troubleshooting

**Issue**: Placeholders not being replaced
- **Solution**: Ensure you're using exact placeholder syntax: `<PLACEHOLDER_NAME>`

**Issue**: Agent hooks not executing
- **Solution**: Verify context files (requirements.md, design.md) exist and are properly formatted

**Issue**: Generated structure doesn't match design
- **Solution**: Review steering files to ensure they align with your design.md specifications

**Issue**: Validation errors after customization
- **Solution**: Run validate-structure.md hook to identify missing or invalid placeholders

## Next Steps

1. Review the template files in `.kiro/specs/agentic-full-stack-skeleton/`
2. Start customizing placeholders with your application concept
3. Configure steering files to match your preferences
4. Execute agent hooks to generate your application scaffold
5. Begin implementing tasks with AI assistance

Ready to build something amazing? Start customizing!

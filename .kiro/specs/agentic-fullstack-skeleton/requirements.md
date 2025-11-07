# Requirements Document

## Introduction

The Agentic Full-Stack Skeleton is a generative template system designed to rapidly produce well-architected, full-stack TypeScript applications from high-level prompts. This is NOT a functional application itself—it is a master blueprint that generates other applications. The skeleton enables solo founders, developer teams, and technical entrepreneurs to validate product concepts through working prototypes with minimal setup time.

## Glossary

- **Skeleton System**: The master template and generation logic that produces full-stack applications
- **Generated Application**: A complete full-stack application created from the Skeleton System based on user input
- **Template File**: A file containing placeholder markers that are replaced during generation
- **Steering File**: AI guidance documents in `.kiro/steering/` that influence code generation behavior
- **Agent Hook**: Automated agent execution triggered by IDE events (e.g., file save, manual trigger)
- **Placeholder Marker**: A text pattern like `<APP_NAME>` that gets replaced with user-specific values
- **Extension Point**: A designated location in the architecture where new functionality can be added

## Requirements

### Requirement 1

**User Story:** As a solo founder, I want to provide a high-level app concept and receive a complete project structure, so that I can start building my MVP immediately without manual scaffolding.

#### Acceptance Criteria

1. WHEN the user provides an app concept description, THE Skeleton System SHALL generate a complete directory structure following the monorepo pattern defined in structure.md
2. THE Skeleton System SHALL create all required configuration files including package.json, tsconfig.json, and vite.config.ts with appropriate settings
3. THE Skeleton System SHALL populate the apps/web and apps/api directories with functional boilerplate code
4. THE Skeleton System SHALL generate a README.md file that includes the user's app name and description
5. WHERE the user specifies core features, THE Skeleton System SHALL create corresponding placeholder components and API routes

### Requirement 2

**User Story:** As a developer using the skeleton, I want template files with clear placeholder markers, so that I can understand what information needs to be customized for my specific application.

#### Acceptance Criteria

1. THE Skeleton System SHALL include a master requirements.md template with placeholder markers for APP_NAME, APP_DESCRIPTION, CORE_FEATURES, and USER_STORIES
2. WHEN a placeholder marker is encountered, THE Skeleton System SHALL replace it with user-provided content during generation
3. THE Skeleton System SHALL use angle bracket notation (e.g., `<PLACEHOLDER_NAME>`) for all placeholder markers
4. THE Skeleton System SHALL provide example values for each placeholder marker in template documentation
5. IF a required placeholder is not provided by the user, THEN THE Skeleton System SHALL prompt for the missing information

### Requirement 3

**User Story:** As a technical entrepreneur, I want the generated application to follow consistent architectural patterns, so that I can easily understand and extend the codebase as my product evolves.

#### Acceptance Criteria

1. THE Skeleton System SHALL generate applications with a three-tier architecture: Frontend Layer, Backend Layer, and Data Layer
2. THE Skeleton System SHALL create a design.md file that documents the architecture, components, and extension points
3. WHEN generating the Backend Layer, THE Skeleton System SHALL implement a services-oriented pattern with routes, services, and data access separated
4. WHEN generating the Frontend Layer, THE Skeleton System SHALL organize code into components, pages, and lib directories
5. THE Skeleton System SHALL define clear extension points in the architecture where new features can be added

### Requirement 4

**User Story:** As a developer team, I want steering files that guide AI code generation, so that all team members receive consistent, high-quality code suggestions aligned with our technology choices.

#### Acceptance Criteria

1. THE Skeleton System SHALL create three steering files in .kiro/steering/: product.md, structure.md, and tech.md
2. THE Skeleton System SHALL populate product.md with sections for vision, target users, value proposition, and design principles
3. THE Skeleton System SHALL populate structure.md with the complete directory structure and file naming conventions
4. THE Skeleton System SHALL populate tech.md with the technology stack including TypeScript, React, Express, Vite, and Tailwind CSS
5. WHERE the user specifies custom technology preferences, THE Skeleton System SHALL update tech.md accordingly

### Requirement 5

**User Story:** As a solo founder validating multiple ideas, I want agent hooks that automate documentation generation, so that my codebase stays documented without manual effort as I iterate quickly.

#### Acceptance Criteria

1. THE Skeleton System SHALL create a .kiro/hooks/ directory for agent hook definitions
2. THE Skeleton System SHALL include a documentation generation hook that triggers on file save events
3. WHEN a component file is saved, THE Skeleton System SHALL update docs/components.md with component documentation
4. WHEN an API route file is saved, THE Skeleton System SHALL update docs/api.md with endpoint documentation
5. THE Skeleton System SHALL provide a manual hook for generating test stubs for new components and services

### Requirement 6

**User Story:** As a developer, I want the skeleton to support local-only development with zero external dependencies, so that I can prototype quickly without setting up databases, cloud services, or authentication systems.

#### Acceptance Criteria

1. THE Skeleton System SHALL configure the Data Layer to use local JSON files in apps/api/src/data/
2. THE Skeleton System SHALL generate data access services that use Node.js fs.promises for file operations
3. THE Skeleton System SHALL NOT include configuration for external databases, cloud storage, or third-party APIs
4. THE Skeleton System SHALL implement in-memory caching for data access performance
5. THE Skeleton System SHALL provide example JSON data files for common data patterns

### Requirement 7

**User Story:** As a technical entrepreneur, I want test stubs automatically generated for all components and services, so that I can implement tests as my application matures without creating test file structure manually.

#### Acceptance Criteria

1. THE Skeleton System SHALL create a tests/ directory with subdirectories for web and api tests
2. WHEN generating a React component, THE Skeleton System SHALL create a corresponding test stub in tests/web/components/
3. WHEN generating an API route, THE Skeleton System SHALL create a corresponding test stub in tests/api/routes/
4. THE Skeleton System SHALL configure Vitest as the test runner with appropriate settings
5. THE Skeleton System SHALL include example test cases in generated test stubs

### Requirement 8

**User Story:** As a developer using the skeleton, I want the generated application to demonstrate flexibility by supporting diverse use cases, so that I can validate the skeleton works for different application types.

#### Acceptance Criteria

1. THE Skeleton System SHALL generate applications with a generic architecture that adapts to different domains
2. THE Skeleton System SHALL support generating both data-heavy applications (e.g., dashboards) and interaction-heavy applications (e.g., productivity tools)
3. WHEN the user describes a specific application type, THE Skeleton System SHALL customize component and service names appropriately
4. THE Skeleton System SHALL provide extension points that accommodate different data models and business logic patterns
5. THE Skeleton System SHALL include documentation explaining how to adapt the generated structure for different use cases

### Requirement 9

**User Story:** As a solo founder, I want clear documentation that explains how to use the skeleton and customize generated applications, so that I can be productive immediately without extensive learning.

#### Acceptance Criteria

1. THE Skeleton System SHALL generate a comprehensive README.md that includes setup instructions, development commands, and architecture overview
2. THE Skeleton System SHALL include inline code comments explaining key architectural decisions
3. THE Skeleton System SHALL provide a docs/ directory with detailed documentation for API endpoints and components
4. THE Skeleton System SHALL include examples of common customization tasks in the documentation
5. THE Skeleton System SHALL document the placeholder replacement process for template files

### Requirement 10

**User Story:** As a developer team, I want the skeleton itself to be maintainable and extensible, so that we can add new template features and improve generation logic over time.

#### Acceptance Criteria

1. THE Skeleton System SHALL organize template files in a templates/ directory with clear naming conventions
2. THE Skeleton System SHALL separate generation logic from template content
3. THE Skeleton System SHALL use TypeScript for all generation scripts with strict type checking enabled
4. THE Skeleton System SHALL include validation logic that verifies generated applications have all required files
5. THE Skeleton System SHALL provide documentation for contributors explaining how to add new templates or modify generation behavior

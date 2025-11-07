# Hook: Generate Boilerplate

## Trigger

Manual execution after scaffolding is complete, when user wants to generate common code patterns based on the design.

## Context Files

- `.kiro/specs/agentic-full-stack-skeleton/design.md`
- `.kiro/specs/agentic-full-stack-skeleton/requirements.md`
- `.kiro/steering/tech.md`
- `.kiro/steering/structure.md`

## Actions

1. **Analyze Data Models**
   - Extract `<DATA_MODELS>` from design.md
   - Identify entity relationships and properties
   - Determine which models need CRUD operations

2. **Generate Backend Boilerplate**
   - **Models/Types**: Create TypeScript interfaces for each data model
   - **Database Schema**: Generate Prisma schema based on data models
   - **API Routes**: Create Express route handlers for each entity
   - **Services**: Generate service layer with business logic stubs
   - **Middleware**: Create authentication, validation, and error handling middleware
   - **Controllers**: Generate controller functions for CRUD operations

3. **Generate Frontend Boilerplate**
   - **Types**: Create TypeScript interfaces matching backend models
   - **API Client**: Generate API service functions for each endpoint
   - **Components**: Create basic component stubs for each feature
   - **Hooks**: Generate custom hooks for data fetching and state management
   - **Contexts**: Create context providers for global state
   - **Routes**: Generate route configuration based on features

4. **Generate Utility Code**
   - **Validation**: Create Zod schemas for data validation
   - **Formatters**: Generate common formatting utilities (dates, currency, etc.)
   - **Constants**: Create constant files for API endpoints, error messages, etc.
   - **Helpers**: Generate helper functions for common operations

5. **Generate Configuration Code**
   - **Environment**: Create environment variable configuration
   - **Database**: Generate database connection and configuration
   - **API**: Create API client configuration with base URL and interceptors
   - **Logging**: Setup logging configuration

6. **Add Code Comments and Documentation**
   - Add JSDoc comments to all generated functions
   - Include TODO comments for implementation details
   - Reference specific requirements in comments
   - Add usage examples in comments

## Validation

1. **Syntax Validation**
   - Verify all generated TypeScript code compiles
   - Check for syntax errors
   - Ensure imports are correct

2. **Structure Validation**
   - Confirm files are in correct directories per structure.md
   - Verify naming conventions are followed
   - Check that module organization matches patterns

3. **Completeness Check**
   - Ensure all data models have corresponding code
   - Verify CRUD operations exist for each entity
   - Check that frontend and backend types match

4. **Standards Compliance**
   - Verify code follows coding standards from tech.md
   - Check that error handling patterns are consistent
   - Ensure API design principles are followed

## Expected Output

```
✓ Generated Backend Boilerplate
  - 5 data models (User, Task, Project, Team, Comment)
  - 5 Prisma schemas
  - 15 API routes
  - 5 service files
  - 3 middleware files
  - 15 controller functions

✓ Generated Frontend Boilerplate
  - 5 TypeScript interfaces
  - 15 API client functions
  - 8 component stubs
  - 5 custom hooks
  - 2 context providers
  - 1 route configuration

✓ Generated Utility Code
  - 5 Zod validation schemas
  - 3 formatter utilities
  - 2 constant files
  - 4 helper functions

✓ Generated Configuration
  - Environment configuration
  - Database connection setup
  - API client configuration
  - Logging setup

Total: 87 files generated

Next Steps:
1. Review generated code for accuracy
2. Implement TODO items in service functions
3. Add business logic to controllers
4. Customize components with UI implementation
5. Run tests to verify boilerplate works
```

## Code Generation Patterns

### Backend Model Example
```typescript
// server/models/Task.ts
/**
 * Task data model
 * Requirements: 2.1, 3.3
 */
export interface Task {
  id: string;
  title: string;
  description: string;
  status: TaskStatus;
  priority: TaskPriority;
  assigneeId: string;
  projectId: string;
  createdAt: Date;
  updatedAt: Date;
}

export enum TaskStatus {
  TODO = 'TODO',
  IN_PROGRESS = 'IN_PROGRESS',
  DONE = 'DONE'
}

export enum TaskPriority {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH'
}
```

### Backend Service Example
```typescript
// server/services/taskService.ts
import { Task } from '../models/Task';

/**
 * Task service for business logic
 * Requirements: 2.1, 3.3
 */
export class TaskService {
  /**
   * Get all tasks for a project
   * TODO: Implement filtering and pagination
   */
  async getTasksByProject(projectId: string): Promise<Task[]> {
    // TODO: Implement database query
    throw new Error('Not implemented');
  }

  /**
   * Create a new task
   * TODO: Implement validation and creation logic
   */
  async createTask(taskData: Partial<Task>): Promise<Task> {
    // TODO: Validate input
    // TODO: Create task in database
    // TODO: Return created task
    throw new Error('Not implemented');
  }

  // Additional CRUD methods...
}
```

### Frontend API Client Example
```typescript
// src/services/taskService.ts
import { Task } from '../models/Task';

/**
 * Task API client
 * Requirements: 2.1, 3.3
 */
export const taskService = {
  /**
   * Fetch all tasks for a project
   */
  async getTasksByProject(projectId: string): Promise<Task[]> {
    const response = await fetch(`/api/v1/projects/${projectId}/tasks`);
    if (!response.ok) throw new Error('Failed to fetch tasks');
    return response.json();
  },

  /**
   * Create a new task
   */
  async createTask(projectId: string, taskData: Partial<Task>): Promise<Task> {
    const response = await fetch(`/api/v1/projects/${projectId}/tasks`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(taskData)
    });
    if (!response.ok) throw new Error('Failed to create task');
    return response.json();
  },

  // Additional CRUD methods...
};
```

### Frontend Hook Example
```typescript
// src/hooks/useTasks.ts
import { useQuery, useMutation, useQueryClient } from 'react-query';
import { taskService } from '../services/taskService';
import { Task } from '../models/Task';

/**
 * Custom hook for task management
 * Requirements: 2.1, 3.3
 */
export function useTasks(projectId: string) {
  const queryClient = useQueryClient();

  const { data: tasks, isLoading, error } = useQuery(
    ['tasks', projectId],
    () => taskService.getTasksByProject(projectId)
  );

  const createTask = useMutation(
    (taskData: Partial<Task>) => taskService.createTask(projectId, taskData),
    {
      onSuccess: () => {
        queryClient.invalidateQueries(['tasks', projectId]);
      }
    }
  );

  return {
    tasks,
    isLoading,
    error,
    createTask: createTask.mutate,
    isCreating: createTask.isLoading
  };
}
```

## Error Handling

- **Missing Data Models**: Report if `<DATA_MODELS>` placeholder not replaced in design.md
- **Invalid Model Definitions**: Handle malformed model specifications gracefully
- **File Creation Failures**: Report permission or path issues
- **Compilation Errors**: Report TypeScript errors in generated code
- **Naming Conflicts**: Detect and report if generated files would overwrite existing code

## Customization Options

Allow users to specify:
- Which models to generate code for (default: all)
- Whether to include test stubs (default: yes)
- API style (REST, GraphQL) based on design.md
- State management approach based on tech.md
- Whether to generate full CRUD or specific operations only

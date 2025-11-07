---
inclusion: always
---

# Technology Stack Standard

All generated applications use this modern, high-velocity TypeScript stack:

## Core Technologies

- **Language**: TypeScript 5.x (strict mode enabled)
- **Frontend Framework**: React 18+ with TypeScript
- **Backend Framework**: Node.js 20+ with Express.js 4.x
- **Build Tool**: Vite 5.x (for fast development and optimized builds)

## Frontend Stack

- **Styling**: Tailwind CSS 3.x (utility-first approach)
- **State Management**: Zustand 4.x (lightweight, hook-based)
- **HTTP Client**: Native Fetch API with custom wrapper
- **Routing**: React Router 6.x (for multi-page apps)
- **UI Components**: Build custom components (no external UI library)

## Backend Stack

- **Web Framework**: Express.js with TypeScript
- **Request Validation**: Zod for schema validation
- **Middleware**: CORS, body-parser, express.json
- **Error Handling**: Centralized error middleware
- **Logging**: Console-based (suitable for local development)

## Testing Stack

- **Test Runner**: Vitest (Vite-native, fast)
- **Testing Library**: @testing-library/react (for components)
- **Assertions**: Vitest's built-in expect API
- **Coverage**: Vitest coverage reports

## Data Persistence

**Local JSON Files Only**

- All data stored in `/apps/api/src/data/*.json`
- Use Node.js `fs.promises` for async file operations
- Implement simple in-memory caching for performance
- No databases, no external storage services

## Development Tools

- **Package Manager**: npm (included with Node.js)
- **Code Quality**: TypeScript strict mode (linting via tsc)
- **Hot Reload**: Vite HMR (frontend), nodemon (backend)
- **Environment**: Local development only, no production config needed

## Dependency Management

Keep dependencies minimal. Only install packages listed above unless absolutely necessary for specific app functionality.

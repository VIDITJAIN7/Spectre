---
inclusion: always
---

# Project Structure Standard

All generated applications MUST follow this monorepo-style directory structure:

```
project-root/
├── .kiro/
│   ├── hooks/              # Active agent hook definitions
│   └── steering/           # Persistent AI guidance files
│       ├── product.md
│       ├── structure.md
│       └── tech.md
├── apps/
│   ├── web/                # Frontend React application
│   │   ├── public/         # Static assets
│   │   └── src/
│   │       ├── components/ # Reusable UI components
│   │       ├── pages/      # Top-level page components
│   │       ├── lib/        # Client utilities and state
│   │       ├── App.tsx     # Root component
│   │       └── main.tsx    # Entry point
│   └── api/                # Backend Node.js server
│       └── src/
│           ├── routes/     # API endpoint definitions
│           ├── services/   # Business logic layer
│           ├── data/       # Local JSON file storage
│           └── server.ts   # Express server setup
├── docs/                   # Auto-generated documentation
│   ├── api.md             # API endpoint reference
│   └── components.md      # Frontend component library
├── tests/                  # Auto-generated test stubs
│   ├── web/               # Frontend tests
│   │   ├── components/    # Component unit tests
│   │   └── pages/         # Page integration tests
│   └── api/               # Backend tests
│       ├── routes/        # Endpoint tests
│       └── services/      # Service layer tests
├── package.json
└── README.md
```

## File Naming Conventions

- React components: PascalCase (e.g., `UserCard.tsx`)
- API routes: kebab-case (e.g., `task-routes.ts`)
- Services: kebab-case with `-service` suffix (e.g., `task-service.ts`)
- Tests: Match source file name with `.test.ts` or `.test.tsx` extension
- Documentation: kebab-case with `.md` extension

## Import Path Rules

- Use relative imports within the same app (`./`, `../`)
- Frontend state management in `src/lib/store`
- Backend utilities in `src/lib/utils`
- Shared types in each app's `src/types` directory

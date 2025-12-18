# Complete Initial Memory Set Example

This shows what a comprehensive memory set looks like after project onboarding. These memories capture essential patterns discovered during initial exploration.

---

## Scenario: E-commerce Platform Project

After onboarding a Node.js/TypeScript e-commerce platform, the agent creates this initial memory set.

---

### Memory 1: `project-structure.md`

```markdown
# Project Structure and Organization

## Repository Layout

```
ecommerce-platform/
├── src/
│   ├── api/           # REST API endpoints (Express routes)
│   ├── services/      # Business logic layer
│   ├── models/        # Database models (Sequelize)
│   ├── middleware/    # Express middleware
│   ├── utils/         # Shared utilities
│   └── types/         # TypeScript type definitions
├── tests/
│   ├── unit/          # Unit tests for services
│   ├── integration/   # API integration tests
│   └── fixtures/      # Test data
├── migrations/        # Database migrations (Sequelize)
└── scripts/           # Deployment and utility scripts
```

## Key Patterns

- **Layered architecture:** API → Services → Models
- **No business logic in routes:** Routes only handle HTTP concerns
- **Dependency injection:** Services receive dependencies via constructor
- **Centralized types:** All TypeScript types in src/types/ (not co-located)

## Import Conventions

```typescript
// Absolute imports from src/ using tsconfig paths
import { UserService } from '@/services/UserService';
import { User } from '@/models/User';
import { ApiResponse } from '@/types/api';
```

## Rationale

Layered architecture enables testing business logic without HTTP layer. Centralized types simplify refactoring when shared types change.
```

---

### Memory 2: `api-conventions.md`

```markdown
# API Conventions and Patterns

## Response Format

All API endpoints return:

```typescript
{
  status: number;        // HTTP status code
  data?: any;           // Success response payload
  error?: {             // Present only on errors
    code: string;
    message: string;
    details?: object;
  };
}
```

## Route Structure

Routes are in `src/api/routes/` organized by resource:

- `src/api/routes/users.ts` - User management
- `src/api/routes/products.ts` - Product catalog
- `src/api/routes/orders.ts` - Order processing

Each route file follows this pattern:

```typescript
import { Router } from 'express';
import { UserService } from '@/services/UserService';
import { authenticate } from '@/middleware/auth';

const router = Router();
const userService = new UserService();

// GET /api/users/:id
router.get('/:id', authenticate, async (req, res, next) => {
  try {
    const user = await userService.getById(req.params.id);
    res.json({ status: 200, data: user });
  } catch (error) {
    next(error); // Handled by error middleware
  }
});

export default router;
```

## Authentication

All protected routes use `authenticate` middleware from `src/middleware/auth.ts`. It validates JWT tokens from Authorization header.

## Error Handling

Centralized in `src/middleware/errorHandler.ts`. Throw errors in routes/services, middleware catches and formats them.
```

---

### Memory 3: `database-schema.md`

```markdown
# Database Schema and Models

## Technology

- **ORM:** Sequelize v6
- **Database:** PostgreSQL 14
- **Migrations:** Sequelize migrations in migrations/

## Core Tables

### users
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### products
```sql
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  inventory_count INTEGER DEFAULT 0,
  category_id UUID REFERENCES categories(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### orders
```sql
CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) NOT NULL,
  status VARCHAR(50) NOT NULL, -- 'pending', 'processing', 'shipped', 'delivered'
  total_amount DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

## Model Conventions

Models in `src/models/` extend Sequelize.Model:

```typescript
// src/models/User.ts
import { Model, DataTypes } from 'sequelize';
import { sequelize } from '@/db/connection';

export class User extends Model {
  public id!: string;
  public email!: string;
  public passwordHash!: string;
  public firstName!: string;
  public lastName!: string;
}

User.init({
  id: { type: DataTypes.UUID, primaryKey: true, defaultValue: DataTypes.UUIDV4 },
  email: { type: DataTypes.STRING, unique: true, allowNull: false },
  passwordHash: { type: DataTypes.STRING, allowNull: false },
  firstName: { type: DataTypes.STRING },
  lastName: { type: DataTypes.STRING }
}, { sequelize, tableName: 'users', underscored: true });
```

## Running Migrations

```bash
npm run migrate        # Run pending migrations
npm run migrate:undo   # Rollback last migration
```
```

---

### Memory 4: `testing-patterns.md`

```markdown
# Testing Conventions and Patterns

## Test Framework

- **Runner:** Jest 29
- **Location:** tests/ directory (not co-located with source)
- **Structure:** Mirrors src/ structure

## Unit Tests

Unit tests in `tests/unit/` test services in isolation with mocked dependencies.

Example: `tests/unit/services/UserService.test.ts`

```typescript
import { UserService } from '@/services/UserService';
import { User } from '@/models/User';

jest.mock('@/models/User');

describe('UserService', () => {
  let userService: UserService;

  beforeEach(() => {
    userService = new UserService();
    jest.clearAllMocks();
  });

  it('should fetch user by id', async () => {
    const mockUser = { id: '123', email: 'test@example.com' };
    (User.findByPk as jest.Mock).mockResolvedValue(mockUser);

    const result = await userService.getById('123');

    expect(result).toEqual(mockUser);
    expect(User.findByPk).toHaveBeenCalledWith('123');
  });
});
```

## Integration Tests

Integration tests in `tests/integration/` test full API endpoints with real database (test DB).

Example: `tests/integration/api/users.test.ts`

```typescript
import request from 'supertest';
import { app } from '@/app';
import { sequelize } from '@/db/connection';

beforeAll(async () => {
  await sequelize.sync({ force: true }); // Reset test DB
});

describe('POST /api/users', () => {
  it('should create a new user', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'new@example.com', password: 'password123' });

    expect(response.status).toBe(201);
    expect(response.body.data).toHaveProperty('id');
    expect(response.body.data.email).toBe('new@example.com');
  });
});
```

## Test Data

Fixtures in `tests/fixtures/` provide reusable test data:

```typescript
// tests/fixtures/users.ts
export const testUser = {
  email: 'test@example.com',
  passwordHash: '$2b$10$...',
  firstName: 'Test',
  lastName: 'User'
};
```

## Running Tests

```bash
npm test              # Run all tests
npm test -- --watch   # Watch mode
npm test -- UserService  # Run specific test file
```

## Coverage Requirements

Minimum 80% coverage required for:
- Services (business logic)
- Models (database logic)
- Middleware

API routes are covered by integration tests, not unit tests.
```

---

### Memory 5: `build-and-deployment.md`

```markdown
# Build Process and Deployment

## Development

```bash
npm run dev           # Start dev server with hot reload (ts-node)
# Runs on http://localhost:3000
# Connects to local PostgreSQL (see .env.development)
```

## Build

```bash
npm run build         # TypeScript compilation to dist/
npm start             # Run production build from dist/
```

Build output: `dist/` directory (gitignored)

## Environment Variables

Three environment files:
- `.env.development` - Local dev (committed with safe defaults)
- `.env.test` - Test database config (committed)
- `.env.production` - Production secrets (NOT committed, deployed separately)

Required variables:
```
DATABASE_URL=postgresql://...
JWT_SECRET=...
PORT=3000
NODE_ENV=development|test|production
```

## Deployment

Deployed to Heroku. Deployment process:

```bash
git push heroku main       # Deploys to Heroku
# Heroku runs: npm install && npm run build && npm start
# Migrations run automatically via release phase (Procfile)
```

Environment variables set in Heroku dashboard.

## Database Migrations in Production

Migrations run automatically via Procfile release phase:

```
release: npm run migrate
web: npm start
```

Manual migration (if needed):
```bash
heroku run npm run migrate
```
```

---

## Why This Is a Good Initial Memory Set

✅ **Comprehensive Coverage:** Architecture, API, database, testing, deployment  
✅ **Specific and Actionable:** File paths, code examples, exact commands  
✅ **Organized by Topic:** Each memory covers one coherent area  
✅ **Cross-Referenced:** Mentions related files and patterns  
✅ **Includes Rationale:** Explains why patterns exist  
✅ **Right Scope:** 5 memories - enough detail without overwhelming  
✅ **Enables Work:** An agent can start contributing immediately with this context  

## What This Enables

With these memories, an agent in a new session can:

1. Understand project structure immediately
2. Add new API endpoints following conventions
3. Write tests matching existing patterns
4. Create database migrations correctly
5. Deploy changes without guidance

This is the goal of initial memory creation after onboarding.

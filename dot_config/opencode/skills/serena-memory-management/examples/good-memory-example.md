# Good Memory Example: API Error Handling Conventions

This example demonstrates well-structured, actionable memory content with specific details, file paths, and rationale.

---

# API Error Handling Conventions

## Context

This project's REST API uses standardized error responses across all endpoints. All error handling logic is centralized in middleware to ensure consistency.

## Response Format

All API errors return a consistent JSON structure:

```json
{
  "status": 400,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable description",
    "details": {
      "field": "specific_field",
      "value": "invalid_value"
    }
  }
}
```

- `status`: HTTP status code (number)
- `error.code`: Machine-readable error code (uppercase snake_case)
- `error.message`: Human-readable description
- `error.details`: Optional object with additional context

## Implementation Location

**Primary file:** `src/middleware/errorHandler.ts`

The error middleware catches all thrown errors and formats them:

```typescript
// src/middleware/errorHandler.ts
export function errorHandler(err: Error, req: Request, res: Response, next: NextFunction) {
  if (err instanceof ValidationError) {
    return res.status(400).json({
      status: 400,
      error: {
        code: 'INVALID_INPUT',
        message: err.message,
        details: err.fields
      }
    });
  }
  
  if (err instanceof AuthenticationError) {
    return res.status(401).json({
      status: 401,
      error: {
        code: 'UNAUTHORIZED',
        message: 'Authentication required'
      }
    });
  }
  
  // Default 500 error
  return res.status(500).json({
    status: 500,
    error: {
      code: 'INTERNAL_ERROR',
      message: 'An unexpected error occurred'
    }
  });
}
```

## Error Code Conventions

All error codes follow this pattern:

| Code | HTTP Status | Usage |
|------|-------------|-------|
| `INVALID_INPUT` | 400 | Validation failures |
| `UNAUTHORIZED` | 401 | Missing or invalid authentication |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource doesn't exist |
| `CONFLICT` | 409 | Resource state conflict (e.g., duplicate email) |
| `INTERNAL_ERROR` | 500 | Unexpected server errors |

**File location:** Error codes are defined as constants in `src/constants/errorCodes.ts`

## Custom Error Classes

The project uses custom error classes to enable type-safe error handling:

```typescript
// src/errors/ValidationError.ts
export class ValidationError extends Error {
  constructor(
    message: string,
    public fields: Record<string, string>
  ) {
    super(message);
    this.name = 'ValidationError';
  }
}

// Usage in route handlers:
if (!isValidEmail(email)) {
  throw new ValidationError('Invalid email format', {
    field: 'email',
    value: email
  });
}
```

**Files:**
- `src/errors/ValidationError.ts`
- `src/errors/AuthenticationError.ts`
- `src/errors/NotFoundError.ts`

## Rationale

**Why this pattern:**

1. **Consistent client experience:** Frontend can implement generic error handling without special cases per endpoint
2. **Type safety:** Custom error classes enable TypeScript type checking
3. **Debuggability:** Error codes enable quick identification in logs
4. **Internationalization ready:** Machine-readable codes can be mapped to localized messages client-side

**Historical context:** This pattern was adopted in v2.0 refactor (commit abc123) to replace inconsistent error responses across routes.

## Related

- Authentication logic: See `authentication-flow.md` memory
- Validation patterns: See `input-validation.md` memory
- Logging: Errors are logged in `src/middleware/logger.ts`

## Frontend Integration

Frontend consumes errors with this pattern:

```typescript
// Frontend error handling (for reference)
try {
  await api.createUser(data);
} catch (error) {
  if (error.response?.data?.error?.code === 'INVALID_INPUT') {
    // Show field-specific validation errors
    showValidationErrors(error.response.data.error.details);
  } else {
    // Show generic error message
    showErrorToast(error.response.data.error.message);
  }
}
```

---

## Why This Is a Good Memory

✅ **Specific:** Includes exact file paths and code examples  
✅ **Actionable:** Provides clear patterns to follow for new endpoints  
✅ **Contextualized:** Explains rationale and historical decisions  
✅ **Cross-referenced:** Links to related memories  
✅ **Structured:** Uses headers, tables, and code blocks for readability  
✅ **Scoped:** Covers one coherent topic (error handling)  

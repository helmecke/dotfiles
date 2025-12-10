# Bad Memory Example: Vague and Unusable Content

This example demonstrates what NOT to do when creating memories. It shows common mistakes that make memories unusable.

---

# Project Information

## General Notes

The project uses TypeScript for development. There are various files in different directories. Some files have tests and some don't. The code follows common patterns.

## API Stuff

The API has endpoints. They return data. Sometimes there are errors. Error handling is done somewhere in the code. The API uses REST I think.

## Testing

Tests are written with Jest probably. They're in test files. Some tests pass and some fail sometimes. Testing is important for code quality.

## Architecture

The project has a good architecture. Files are organized logically. There are different layers like frontend and backend. Components are modular.

## Conventions

We follow best practices. Code should be clean and readable. Use meaningful variable names. Don't repeat yourself. Keep functions small.

## Database

There's a database. It stores data. Tables exist with columns. Queries are used to get data. The schema is defined somewhere.

## Deployment

The app gets deployed somehow. There's a build process. Environment variables are used for configuration. The deployment works most of the time.

## Recent Changes

- Fixed some bugs
- Updated dependencies
- Changed some files
- Improved performance
- Added new features

## TODO

- Fix remaining issues
- Update documentation
- Review code
- Test thoroughly

---

## Why This Is a Bad Memory

❌ **Vague:** No specific file paths, code examples, or concrete patterns  
❌ **Not Actionable:** Can't use this information to make decisions or write code  
❌ **Generic:** "Best practices" and "clean code" are obvious, not project-specific  
❌ **Unstructured:** Random collection of vague observations  
❌ **No Context:** Missing rationale, history, or reasoning  
❌ **Unhelpful Examples:** "Some tests" "somewhere in the code" "probably"  
❌ **Duplicate:** Repeats obvious information that doesn't need documentation  
❌ **No Specificity:** Every statement is generic and could apply to any project  

## What Would Make This Better

**Instead of:** "The API has endpoints that return data"  
**Write:** "All API endpoints in src/api/ return { status, data, error } format (see src/types/ApiResponse.ts)"

**Instead of:** "Tests are written with Jest probably"  
**Write:** "Tests in __tests__/ use Jest with custom matchers from test/helpers.ts. Run with npm test"

**Instead of:** "Error handling is done somewhere"  
**Write:** "Error middleware in src/middleware/errorHandler.ts catches all exceptions and formats responses according to error conventions"

**Instead of:** "The database stores data"  
**Write:** "PostgreSQL database with schema in migrations/. User table has columns: id, email, passwordHash, createdAt. See src/db/schema.sql"

**Instead of:** "Fixed some bugs"  
**Write:** Don't memorize transient changes at all. Only memorize patterns that emerged.

## Key Lessons

1. **Be Specific:** Include exact file paths, function names, and code examples
2. **Be Actionable:** Information should enable decision-making or code writing
3. **Be Scoped:** Cover one coherent topic per memory, not random notes
4. **Include Context:** Explain why patterns exist, not just what they are
5. **Avoid Obvious:** Don't document generic "best practices" - focus on project-specific patterns
6. **Show Examples:** Code examples are worth more than vague descriptions
7. **Reference Locations:** Always indicate where in the codebase patterns are implemented

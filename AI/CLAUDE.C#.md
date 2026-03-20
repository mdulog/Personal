# CLAUDE.md — Global C# Enterprise Standards

This file provides universal guidance to Claude Code across all C# solutions in this organization. 
Repo-specific CLAUDE.md files may extend or override these rules but must not contradict them 
without explicit justification.

---

## General behavior

- Read the repo-level CLAUDE.md first before making any changes.
- Inspect existing code, patterns, and folder structures before writing anything new.
- Follow what is already in the repo before introducing your own preferences.
- Prefer small, focused, targeted changes over broad refactors.
- Never introduce new frameworks, libraries, or architectural patterns unless explicitly asked.
- Never rename, reorganize, or restructure files unless the task explicitly requests it.
- If the request is ambiguous, inspect existing code for patterns and match them.
- If something feels wrong or risky, state it clearly instead of silently proceeding.
- Do not explain obvious code. Keep comments meaningful and rare.

---

## C# coding standards

### Language and syntax
- Target the C# version defined in the project's `<LangVersion>` or `.editorconfig`.
- Use file-scoped namespaces if the project already uses them.
- Enable and respect nullable reference types (`#nullable enable` or `<Nullable>enable</Nullable>`).
- Use `var` only when the inferred type is immediately obvious from context.
- Use explicit types when clarity matters more than brevity.
- Use expression bodies only for simple, single-expression members.
- Use primary constructors only if the rest of the codebase does.
- Prefer `required` properties and `init` setters over constructor bloat for DTOs and records.

### Naming
- Classes, methods, properties, and namespaces use `PascalCase`.
- Private fields use `_camelCase` with a leading underscore.
- Local variables and parameters use `camelCase`.
- Async methods must end with `Async`.
- Interfaces must start with `I`.
- Avoid abbreviations unless they are universally understood (`Id`, `Url`, `Http`).

### Methods and classes
- Keep methods short and focused on one responsibility.
- Keep classes small; a class that does many things should be split.
- Use constructor injection for dependencies; avoid service locators and static access.
- Avoid `static` state except for true constants and truly stateless utility methods.
- Mark everything `private` by default; widen access only when needed.
- Prefer immutable models where practical.

### Async
- Use `async`/`await` end-to-end for all I/O-bound operations.
- Always accept `CancellationToken` in public async methods and pass it through.
- Never use `.Result`, `.Wait()`, or `.GetAwaiter().GetResult()` except at true entry points.
- Avoid `async void` except for event handlers.
- Do not use `Task.Run` for I/O work; only use it for CPU-bound work that must be offloaded.

### Error handling
- Throw meaningful exceptions with useful messages.
- Prefer specific exception types over `Exception`.
- Do not swallow exceptions silently. If you catch, handle or rethrow explicitly.
- Use result/discriminated union patterns if the repo already uses them.

### Dependencies and abstractions
- Prefer dependency injection over `new`-ing dependencies directly.
- Do not add abstractions speculatively; only abstract what has more than one implementation or needs testing isolation.
- Keep interfaces focused and minimal.

---

## Architecture rules

- Respect the architectural layers of the solution: do not skip layers.
- Business logic belongs in the domain or application layer, not in controllers, endpoints, handlers, or infrastructure.
- Infrastructure concerns (database, HTTP clients, file system) must not leak into domain or application layers.
- Keep controllers and API endpoints thin; they coordinate, they do not decide.
- Use repositories only where persistence abstraction is genuinely needed.
- Do not add cross-cutting concerns (logging, validation, caching) inline; use middleware, decorators, or pipeline behaviors.
- Follow the naming and folder structure already established in the solution.

---

## Testing rules (TUnit)

### Framework
- Use TUnit for all new tests unless the repo explicitly standardizes on a different framework.
- Use `[Test]` for standard tests.
- Use `[Arguments]` or data sources for parameterized tests.
- Do not mix xUnit or NUnit conventions with TUnit tests.

### What to test
- Test behavior and outcomes, not implementation details.
- Cover happy paths, failure paths, boundary values, null/empty inputs, and regressions.
- Every public API or domain behavior should have at least one test protecting it.
- If a behavior is important enough to change, it is important enough to test.

### How to test
- Prefer real objects and small in-memory fakes over heavy mock frameworks.
- Use mocks only for boundaries you cannot substitute (external APIs, third-party SDKs).
- Do not write tests that only verify mock calls or assert internal state directly.
- Keep tests independent; each test must set up and tear down its own state.
- Use unique data per test to avoid shared state interference.
- Use `[DependsOn]` only when a test genuinely requires a prior test to complete first.
- Use `NotInParallel` only when shared resources make parallel execution unsafe.
- Always await TUnit assertions and async operations.

### Test quality
- Each test should focus on one behavior.
- Test names should describe the behavior being verified, not the method name.
- Do not copy-paste test setup; extract helpers or fixtures instead.
- If a test is brittle or hard to maintain, fix the design, not the test.
- If code is hard to test, suggest the smallest safe refactor instead of writing fragile tests.

### After writing tests
- Build and run the affected test project.
- Fix all analyzer and style warnings before finishing.
- Confirm the test actually fails when the behavior is broken (red/green sanity check).

---

## Code style and formatting

- Always follow the project's `.editorconfig` rules.
- Run `dotnet format` before finishing any change that touched formatting.
- Do not reformat files that were not part of the change.
- Respect analyzer rules; fix warnings rather than suppress them without justification.
- If suppression is required, add a comment explaining why.

---

## Safety and quality gates

Before completing any change:
1. `dotnet build [solution]` — confirm no build errors.
2. `dotnet test [relevant test project]` — confirm tests pass.
3. `dotnet format --verify-no-changes` — confirm formatting is clean.
4. Confirm no new analyzer warnings were introduced.
5. If EF Core migrations were affected, verify they are consistent with the data model.

---

## Commands reference

```bash
# Build
dotnet build

# Run all tests
dotnet test

# Run tests with output
dotnet test --logger "console;verbosity=detailed"

# Format
dotnet format

# Check formatting without writing
dotnet format --verify-no-changes

# Run a single test project
dotnet test ./tests/[ProjectName]/

# EF Core – add migration
dotnet ef migrations add [Name] \
  --project [InfrastructureProject] \
  --startup-project [ApiProject]

# EF Core – apply migrations
dotnet ef database update \
  --project [InfrastructureProject] \
  --startup-project [ApiProject]

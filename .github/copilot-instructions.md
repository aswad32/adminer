# Copilot Instructions — Adminer UI Modernization

## Project Goal

This project is a fork of Adminer. The goal is to modernize the user interface while preserving Adminer's existing behavior, database support, portability, and lightweight nature.

The main objective is **UI modernization only**, not a full rewrite.

Modernization should improve:

- Visual design
- Layout clarity
- Spacing and typography
- Tables
- Forms
- Buttons
- Navigation
- Login screen
- Responsive behavior
- Optional dark mode support

The project must continue to behave like Adminer.

---

## Important Context

Adminer is a legacy-style PHP application where PHP logic and HTML output are often mixed together.

Because of this, UI changes must be made carefully. Some HTML elements are directly connected to form submission, routing, query parameters, session handling, database actions, and SQL execution.

Do not assume markup is purely visual.

---

## Absolute Rules

Copilot must follow these rules strictly:

1. Do not rewrite the application architecture.
2. Do not convert the project to React, Vue, Angular, Svelte, or any frontend SPA framework.
3. Do not change database logic.
4. Do not change SQL execution behavior.
5. Do not change authentication, session, or permission logic.
6. Do not rename existing form fields.
7. Do not remove hidden inputs.
8. Do not change form `method` or `action` attributes unless explicitly requested.
9. Do not change existing query parameters or URL behavior.
10. Do not change driver-specific database behavior.
11. Do not remove accessibility-related attributes.
12. Do not introduce large JavaScript dependencies.
13. Do not make broad changes across many screens in one step.
14. Do not optimize or refactor backend logic unless explicitly requested.
15. Do not change behavior while modernizing UI.

When uncertain, preserve the existing code behavior.

---

## Preferred Approach

Use a safe, incremental approach.

Priority order:

1. CSS-first modernization
2. Add wrapper classes around existing markup
3. Improve spacing, typography, buttons, forms, and tables
4. Refactor repeated UI output into small PHP helper functions only when safe
5. Improve one screen at a time
6. Avoid large-scale structural changes

Prefer small, reviewable pull requests.

---

## UI Modernization Strategy

Start by improving global UI styles before changing deep PHP logic.

Recommended first areas:

1. Login page
2. Main layout shell
3. Sidebar / navigation
4. Header / top actions
5. Table browsing screen
6. Forms for insert/edit/update
7. SQL command screen
8. Export/import screens
9. Messages, warnings, and error states
10. Responsive layout improvements

Each UI change should preserve existing behavior.

---

## Mandatory Workflow — Issue First

**Every code change requires a GitHub issue before any branch or file is touched.**

```
gh issue create → git checkout develop && git pull origin develop → git checkout -b feature/<issue-number>-short-description → implement → commit → git push → gh pr create --base develop
```

Always pull the latest `develop` from remote before branching. This ensures you build on top of all merged work from other team members and avoids unnecessary merge conflicts.

Full steps: see [`specs/contributing.md`](../specs/contributing.md).

- Branch naming: `feature/<issue-number>-<short-kebab-description>`
- Commit message: `feat: description (#N)` with `Closes #N` in the body
- PRs always target `develop`, never `main`
- Labels: `enhancement`, `bug`, `documentation`, `other`

---

## Styling Guidelines

Prefer modern plain CSS unless otherwise instructed.

Use:

- CSS variables
- Consistent spacing scale
- Consistent border radius
- Modern typography
- Clear focus states
- Accessible color contrast
- Responsive layout
- Minimal JavaScript

Example CSS direction:

```css
:root {
  --color-bg: #f8fafc;
  --color-surface: #ffffff;
  --color-text: #0f172a;
  --color-muted: #64748b;
  --color-border: #e2e8f0;
  --color-primary: #2563eb;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
  --shadow-sm: 0 1px 2px rgba(15, 23, 42, 0.08);
}
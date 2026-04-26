# Spec: CSS Design System

**Priority:** 1 (must be done before all other UI tasks)  
**Risk:** Low — CSS-only, no PHP changes  
**Screen:** Global

---

## Goal

Replace the minimal 4-variable CSS system with a full design token system using CSS custom properties. All subsequent UI tasks will reference these tokens.

---

## Current State

`adminer/static/default.css` defines only four variables on `html {}`:

```css
html {
    --bg: #fff;
    --fg: #000;
    --dim: #eee;
    --lit: #ddf;
}
```

The dark theme overrides these same four in `adminer/static/dark.css`.

Typography is set on `body`:
```css
body { font: 90%/1.25 Verdana, Arial, Helvetica, sans-serif; }
```

Spacing, radius, shadow, and color are all hard-coded throughout the stylesheet.

---

## Tasks

### TASK-CSS-01: Define expanded CSS variable set on `html {}`

Add to `adminer/static/default.css`, expanding the existing `html {}` block:

```css
html {
    /* Existing — keep these */
    --bg: #fff;
    --fg: #000;
    --dim: #f1f5f9;
    --lit: #e0e7ff;

    /* Surfaces */
    --color-surface: #ffffff;
    --color-surface-raised: #f8fafc;
    --color-border: #e2e8f0;

    /* Text */
    --color-text: #0f172a;
    --color-muted: #64748b;

    /* Brand / primary */
    --color-primary: #2563eb;
    --color-primary-hover: #1d4ed8;

    /* Status */
    --color-success-bg: #f0fdf4;
    --color-success-text: #166534;
    --color-success-border: #bbf7d0;
    --color-error-bg: #fef2f2;
    --color-error-text: #991b1b;
    --color-error-border: #fecaca;

    /* Spacing scale */
    --space-1: 4px;
    --space-2: 8px;
    --space-3: 12px;
    --space-4: 16px;
    --space-5: 20px;
    --space-6: 24px;

    /* Border radius */
    --radius-sm: 4px;
    --radius-md: 8px;
    --radius-lg: 12px;

    /* Shadow */
    --shadow-sm: 0 1px 3px rgba(15,23,42,0.08);
    --shadow-md: 0 4px 12px rgba(15,23,42,0.12);

    /* Typography */
    --font-body: system-ui, -apple-system, "Segoe UI", sans-serif;
    --font-mono: ui-monospace, "SFMono-Regular", Consolas, monospace;
    --font-size-base: 14px;
    --line-height: 1.5;
}
```

**Preserve:** Keep `--bg`, `--fg`, `--dim`, `--lit` so existing designs and dark.css still work.

---

### TASK-CSS-02: Update `body {}` typography

Replace:
```css
body { color: var(--fg); background: var(--bg); font: 90%/1.25 Verdana, Arial, Helvetica, sans-serif; ... }
```

With:
```css
body {
    color: var(--color-text);
    background: var(--bg);
    font-family: var(--font-body);
    font-size: var(--font-size-base);
    line-height: var(--line-height);
    margin: 0;
    min-width: fit-content;
}
```

---

### TASK-CSS-03: Update `dark.css` dark token overrides

Add dark-mode equivalents of all new tokens to `adminer/static/dark.css`:

```css
html {
    /* Existing */
    --bg: #002240;
    --fg: #829bb0;
    --dim: #154269;
    --lit: #011d35;

    /* New tokens — dark overrides */
    --color-surface: #011d35;
    --color-surface-raised: #0c2d4a;
    --color-border: #1a4570;
    --color-text: #c8d8e8;
    --color-muted: #5e8ab0;
    --color-primary: #3b82f6;
    --color-primary-hover: #60a5fa;
    --color-success-bg: #052e16;
    --color-success-text: #86efac;
    --color-success-border: #166534;
    --color-error-bg: #450a0a;
    --color-error-text: #fca5a5;
    --color-error-border: #991b1b;
}
```

---

### TASK-CSS-04: Migrate hard-coded color values to tokens

Audit `default.css` and replace hard-coded colors with the new tokens where safe. Target:

- `#999` border colors → `var(--color-border)`
- `color: red` on errors → `var(--color-error-text)`
- `background: #fee` on errors → `var(--color-error-bg)`
- `color: green` on messages → `var(--color-success-text)`
- `background: #efe` on messages → `var(--color-success-bg)`
- `color: #777` muted text → `var(--color-muted)`

**Do not** replace colors that are part of syntax highlighting (`.char`, `.date`, `.enum`, `.binary`).

---

## Acceptance Criteria

- [ ] All new variables defined on `html {}`
- [ ] Dark overrides defined in `dark.css`
- [ ] Existing designs still render (they override `--bg`, `--fg`, `--dim`, `--lit`)
- [ ] No behavior changes
- [ ] `Adminer::css()` return value unchanged
- [ ] No PHP files modified

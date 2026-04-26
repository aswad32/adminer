# Spec: Dark Mode Support

**Priority:** 13  
**Risk:** Low — extends existing dark.css pattern  
**Screen:** All screens  
**PHP source:** `Adminer::head()`, `Adminer::css()` — no changes needed

---

## Goal

Extend the dark mode CSS to cover all new design tokens added in TASK-CSS-01 through TASK-CSS-04. Ensure the dark theme is complete and consistent when `prefers-color-scheme: dark` is active.

---

## Current State

`adminer/static/dark.css` overrides `--bg`, `--fg`, `--dim`, `--lit` and a set of hard-coded selectors. After the design token expansion in spec `01-css-design-system.md`, all new tokens must also have dark overrides.

The dark CSS is loaded automatically when the system prefers dark mode (via `media="(prefers-color-scheme: dark)"`) unless a custom `adminer-dark.css` is present.

The `dark-switcher.php` plugin allows manual toggle — it adds/removes a `dark` class to `<body>`. Any dark mode CSS should also work when `body.dark` class is set.

---

## Tasks

### TASK-DARK-01: New token dark overrides

Add to `adminer/static/dark.css` (already covered in TASK-CSS-03):

```css
html {
    /* Existing — keep unchanged */
    --bg: #002240;
    --fg: #829bb0;
    --dim: #154269;
    --lit: #011d35;

    /* New token overrides */
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

### TASK-DARK-02: Dark mode form controls

Browser default form controls often look inconsistent in dark mode. Add:

```css
/* Ensure inputs use token colors in dark mode */
input,
select,
textarea {
    color-scheme: dark;
}
```

---

### TASK-DARK-03: Dark mode icon inversion

Already handled in existing dark.css:
```css
.icon { filter: invert(1); background-color: #062642; }
.icon:hover { background-color: #d1394e; }
```

Verify these still apply after TASK-BTN-04 icon changes. No action needed if values unchanged.

---

### TASK-DARK-04: Dark mode schema diagram

Schema cards need to look correct in dark mode:

```css
#schema .table {
    border-color: var(--color-border);
    background: var(--color-surface);
}

#schema .references {
    /* SVG arrows — color is set inline by JS/PHP, may need a CSS filter */
}
```

---

### TASK-DARK-05: Body class dark toggle (dark-switcher plugin)

The `dark-switcher.php` plugin adds a `dark` class to `<body>`. For compatibility, wrap dark token overrides in a dual selector:

```css
/* In dark.css — already loaded via media query,
   also support body.dark class for manual toggle plugin */
html,
body.dark {
    --bg: #002240;
    /* ... all dark tokens ... */
}
```

This is a CSS-only change. The PHP plugin (`plugins/dark-switcher.php`) does not need changes.

---

## Acceptance Criteria

- [ ] Dark mode activates via `prefers-color-scheme: dark` system setting
- [ ] Dark mode activates via `body.dark` class (dark-switcher plugin)
- [ ] All new UI components look correct in dark mode
- [ ] Icon buttons visible in dark mode (via `filter: invert(1)`)
- [ ] Syntax highlighting (jush-dark.css) still loads in dark mode
- [ ] Existing custom designs (e.g., `designs/dracula/`) not broken
- [ ] No PHP files modified

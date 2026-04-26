# Spec: Buttons & Interactive Controls

**Priority:** 5  
**Risk:** Low — pure CSS, no HTML or PHP changes  
**Screen:** All screens  
**PHP source:** Submit buttons rendered inline in all `*.inc.php` files; icons via `icon()` helper

---

## Goal

Establish a consistent, modern button and control style across all screens. All buttons remain `<input type="submit">` or `<button>` elements — no HTML changes are needed.

---

## Current State

Buttons are completely unstyled — they use the browser default appearance. Icon buttons (`.icon`) are 18×18px elements with `background-image` (base64 GIF).

```css
/* Existing button-related rules */
input.default { box-shadow: 1px 1px 1px #777; }
input.required, input.maxlength { box-shadow: 1px 1px 1px red; }
.icon { width: 18px; height: 18px; background: navy center no-repeat; border: 0; padding: 0; vertical-align: middle; }
.icon span { display: none; }
.icon:hover { background-color: red; }
```

---

## Tasks

### TASK-BTN-01: Primary submit button

Style all `<input type="submit">` as modern buttons:

```css
input[type="submit"],
button[type="submit"] {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: var(--space-2) var(--space-5);
    background: var(--color-primary);
    color: #fff;
    border: 1px solid var(--color-primary);
    border-radius: var(--radius-sm);
    font-size: var(--font-size-base);
    font-family: var(--font-body);
    font-weight: 500;
    cursor: pointer;
    transition: background 0.15s, border-color 0.15s;
    white-space: nowrap;
}

input[type="submit"]:hover,
button[type="submit"]:hover {
    background: var(--color-primary-hover);
    border-color: var(--color-primary-hover);
}

input[type="submit"]:focus-visible,
button[type="submit"]:focus-visible {
    outline: 2px solid var(--color-primary);
    outline-offset: 2px;
}

/* Keep .default highlight for the primary save action */
input.default {
    box-shadow: none;
    outline: 2px solid var(--color-primary);
    outline-offset: 2px;
}
```

---

### TASK-BTN-02: Danger / destructive button variants

Some submit buttons perform destructive actions (Drop, Truncate, Delete). PHP renders these as regular `<input type="submit" name="drop">` etc. We cannot add classes in PHP without editing PHP files. Use attribute selectors where possible, or accept uniform styling for now.

If a PHP change is acceptable for one file: `edit.inc.php` renders `<input type="submit" name="delete" value="Delete">`. Adding `class="danger"` to that one input is a minimal, safe PHP edit.

```css
/* If class added via PHP: */
input.danger {
    background: var(--color-error-text);
    border-color: var(--color-error-text);
    color: #fff;
}

input.danger:hover {
    background: #7f1d1d;
    border-color: #7f1d1d;
}
```

**Decision required:** Whether to make minimal PHP changes to add classes. See `edit.inc.php` line that renders delete button.

---

### TASK-BTN-03: Secondary / neutral buttons

Some buttons are not primary (e.g., "Clone", "Cancel"-like actions). For now, use a secondary style for `<input type="button">` and `<a>` links styled as buttons:

```css
input[type="button"] {
    padding: var(--space-2) var(--space-4);
    background: var(--color-surface);
    color: var(--color-text);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    font-size: var(--font-size-base);
    cursor: pointer;
    transition: background 0.15s;
}

input[type="button"]:hover {
    background: var(--color-surface-raised);
}
```

---

### TASK-BTN-04: Icon buttons (`.icon`)

Icon buttons are `<input type="image">` or `<button>` with class `icon`. They use base64 GIF background images. Keep the image; modernize the container:

```css
.icon {
    width: 22px;
    height: 22px;
    background-color: transparent;
    background-size: 14px 14px;
    background-position: center;
    background-repeat: no-repeat;
    border: 0;
    border-radius: var(--radius-sm);
    padding: 0;
    cursor: pointer;
    vertical-align: middle;
    transition: background-color 0.15s;
}

.icon:hover {
    background-color: var(--color-surface-raised);
}

/* Dark mode icon inversion is already handled by dark.css: filter: invert(1) */
```

---

### TASK-BTN-05: Form action bar (`.footer`)

The sticky footer fieldset area on the select/browse screen uses class `.footer`. Modernize:

```css
.footer {
    position: sticky;
    bottom: 0;
    margin: var(--space-6) calc(-1 * var(--space-5)) 0;
    box-shadow: 0 -2px 8px rgba(15,23,42,0.08);
}

.footer > div {
    background: var(--color-surface);
    padding: var(--space-3) var(--space-5);
    border-top: 1px solid var(--color-border);
}
```

---

### TASK-BTN-06: Text inputs and selects (global)

```css
input[type="text"],
input[type="number"],
input[type="search"],
input[type="password"],
input[type="email"],
input[type="url"],
select,
textarea {
    padding: var(--space-2) var(--space-3);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    font-size: var(--font-size-base);
    font-family: var(--font-body);
    background: var(--color-surface);
    color: var(--color-text);
    box-sizing: border-box;
    transition: border-color 0.15s, outline 0.15s;
}

input:focus,
select:focus,
textarea:focus {
    outline: 2px solid var(--color-primary);
    outline-offset: -1px;
    border-color: var(--color-primary);
}

/* Keep validation states */
input.required,
input.maxlength {
    border-color: var(--color-error-text);
    box-shadow: none;
}
```

---

## Acceptance Criteria

- [ ] All submit buttons visible and clickable
- [ ] `input.default` still visually highlighted as primary action
- [ ] `input.required` / `input.maxlength` error states preserved
- [ ] Icon buttons (`.icon`) still show correct background images
- [ ] Dark mode icon filter still applied
- [ ] No `name`, `value`, `type`, `action`, `method` attributes changed
- [ ] No PHP files modified (except optional TASK-BTN-02 PHP change)

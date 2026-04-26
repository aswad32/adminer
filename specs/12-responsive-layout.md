# Spec: Responsive Layout Improvements

**Priority:** 12  
**Risk:** Low — extends existing media queries  
**Screen:** All screens  
**PHP source:** None — CSS only

---

## Goal

Improve the mobile/small-screen experience. The current responsive breakpoint is `800px`. Enhance the collapsed sidebar, stacked layout, and touch targets.

---

## Current Mobile Behavior (`@media (max-width: 800px)`)

```css
#menu { position: static; width: auto; min-width: 23em; background: var(--bg); border: 1px solid var(--fg); margin-top: 9px; box-shadow: 0 0 20px -3px var(--fg); }
#content { margin-left: 10px !important; }
#lang { position: static; }
#breadcrumb { left: 48px !important; }
.js #foot { position: absolute; top: 2em; left: 0; }
.js .foot { display: none; }
.js #menuopen { display: block; position: absolute; top: 3px; left: 6px; }
.nojs #menu { position: static; }
```

The sidebar collapses behind the hamburger `#menuopen` button. When open (`.foot` class removed), `#foot` overlaps the content.

---

## Tasks

### TASK-RESP-01: Improved mobile sidebar overlay

```css
@media all and (max-width: 800px) {
    /* Keep existing layout rules */
    .js #foot {
        position: fixed; /* was absolute — fixed keeps it in place on scroll */
        top: 2.5em;
        left: 0;
        z-index: 100;
        max-height: calc(100vh - 2.5em);
        overflow-y: auto;
    }

    #menu {
        position: static;
        width: 280px;
        min-width: unset;
        background: var(--color-surface);
        border: none;
        border-right: 1px solid var(--color-border);
        box-shadow: var(--shadow-md);
        margin: 0;
    }

    /* Backdrop when sidebar open */
    .js #foot::before {
        content: '';
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.3);
        z-index: -1;
    }

    .js .foot {
        display: none;
    }

    .js .foot::before {
        display: none;
    }
}
```

---

### TASK-RESP-02: Touch targets

Minimum 44px touch targets for interactive elements on mobile:

```css
@media all and (max-width: 800px) {
    #tables a,
    #logins a,
    #menu .links a {
        min-height: 44px;
        display: flex;
        align-items: center;
        padding: var(--space-2) var(--space-4);
    }

    #menuopen {
        min-width: 44px;
        min-height: 44px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
}
```

---

### TASK-RESP-03: Responsive breadcrumb

On very narrow screens, the breadcrumb can overflow. Add overflow handling:

```css
@media all and (max-width: 800px) {
    #breadcrumb {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: calc(100vw - 60px);
    }
}
```

---

### TASK-RESP-04: Responsive tables

On narrow screens, data tables are already inside `.scrollable` wrappers (horizontal scroll). Ensure this is applied consistently. No PHP change — verify `.scrollable` wrapper exists on all data table screens.

```css
@media all and (max-width: 800px) {
    .scrollable {
        -webkit-overflow-scrolling: touch;
    }

    /* Fieldsets stack vertically on mobile */
    fieldset {
        display: block;
        width: 100%;
        box-sizing: border-box;
        margin-right: 0;
    }
}
```

---

### TASK-RESP-05: Responsive logout area

```css
@media all and (max-width: 800px) {
    .js .logout {
        top: 1.667em;
        background-color: var(--color-surface-raised);
        box-shadow: 0 0 5px 5px var(--color-surface-raised);
        border: none;
        border-radius: 0;
        font-size: 12px;
    }
}
```

---

## Acceptance Criteria

- [ ] Hamburger button appears on screens ≤800px
- [ ] Sidebar toggles open/closed via `#menuopen` click
- [ ] `.foot` / `.js .foot` CSS class toggle still drives show/hide
- [ ] Content is not obscured when sidebar is closed
- [ ] Tables are horizontally scrollable on narrow screens
- [ ] No PHP files modified

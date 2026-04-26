# Spec: Data Tables (Browse / Select Screen)

**Priority:** 6  
**Risk:** Medium — table JS interactions (inline edit, row selection) must be preserved  
**Screen:** `select.inc.php` (Browse table rows), `db.inc.php` (table list), `table.inc.php` (structure), `variables.inc.php`, `processlist.inc.php`  
**PHP source:** `Adminer::tableStructurePrint()`, `Adminer::tableIndexesPrint()`, `Adminer::selectVal()` in `adminer/include/adminer.inc.php`; main select table in `select.inc.php`

---

## Goal

Make data tables cleaner, more readable, and more scannable. Improve row spacing, header styling, and selected/hover states. Preserve all JS-driven interaction.

---

## Current State

```css
table { margin: 1em 20px 0 0; font-size: 90%; border-spacing: 0; border-width: 1px 0 0 1px; }
table, td, th, .js .column { border-color: #999; border-style: solid; }
td, th { border-width: 0 1px 1px 0; padding: .2em .3em; margin: 0; }
th { background: var(--dim); text-align: left; }
thead { position: sticky; top: 0; }
thead th { text-align: center; padding: .2em .5em; }
thead td, thead th { background: var(--lit); }
tbody tr:hover td, tbody tr:hover th { background: var(--dim); }
.odds tbody tr { background: var(--bg); }
.odds tbody tr:nth-child(2n) { background: #F5F5F5; }
.js .checkable .checked td, .js .checkable .checked th { background: var(--lit); }
```

### Key table classes

| Class | Meaning |
|---|---|
| `.nowrap` | White-space: pre (query results) |
| `.checkable` | Rows can be selected via checkbox |
| `.checked` | Row is currently selected |
| `.odds` | Alternating row colors |
| `.scrollable` | Wrapper div, horizontal scroll |
| `.wrap` | Normal white-space |

### Key JS behavior

- `tableClick` / `partialArg(tableClick, true)` on `onclick`/`ondblclick` selects rows in `.checkable` tables
- `.checked` class is toggled by JS on `<tr>` elements
- Inline edit is triggered by double-clicking a cell
- `thead` is `position: sticky; top: 0` — this must be preserved

---

## Tasks

### TASK-TABLE-01: Base table reset and spacing

```css
table {
    margin: 0 0 var(--space-5) 0;
    font-size: var(--font-size-base);
    border-spacing: 0;
    border-collapse: collapse;
    width: auto;
}

td, th {
    padding: var(--space-2) var(--space-3);
    border: 1px solid var(--color-border);
    vertical-align: top;
    font-size: inherit;
}
```

**Note:** The existing border model uses `border-width: 1px 0 0 1px` on `table` and `border-width: 0 1px 1px 0` on cells to avoid double borders. With `border-collapse: collapse`, this is handled automatically. Test carefully with the existing border color CSS variable chain.

---

### TASK-TABLE-02: Column headers (`th`, `thead`)

```css
th {
    background: var(--color-surface-raised);
    text-align: left;
    font-weight: 600;
    font-size: 12px;
    color: var(--color-muted);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    border-color: var(--color-border);
    white-space: nowrap;
}

thead {
    position: sticky;
    top: 0;
    z-index: 1;
}

thead th {
    text-align: center;
    background: var(--color-surface-raised);
    border-bottom: 2px solid var(--color-border);
}

thead td,
thead th {
    background: var(--color-surface-raised);
}
```

---

### TASK-TABLE-03: Row hover and selection states

```css
tbody tr:hover td,
tbody tr:hover th {
    background: var(--dim);
}

/* Alternating rows */
.odds tbody tr {
    background: var(--bg);
}

.odds tbody tr:nth-child(2n) {
    background: var(--color-surface-raised);
}

/* Selected row (JS toggles .checked on <tr>) */
.js .checkable .checked td,
.js .checkable .checked th {
    background: var(--lit);
}
```

---

### TASK-TABLE-04: Scrollable table wrapper

```css
.scrollable {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    margin-bottom: var(--space-4);
}

/* Ensure sticky header works inside scroll container */
.scrollable table {
    min-width: max-content;
}
```

---

### TASK-TABLE-05: Null / special value display

```css
/* NULL values shown as <i>NULL</i> */
td i {
    color: var(--color-muted);
    font-style: italic;
    font-size: 12px;
}

/* Char / binary / date type coloring — keep existing */
.char  { color: #007F00; }
.date  { color: #7F007F; }
.enum  { color: #007F7F; }
.binary { color: var(--color-error-text); }
```

---

### TASK-TABLE-06: Pagination (`.pages`)

Pagination links appear above/below the browse table. Currently positioned `sticky; left: 21em`.

```css
.pages {
    position: sticky;
    left: 21em;
    font-size: 13px;
    padding: var(--space-2) 0;
    margin-bottom: var(--space-3);
}

.pages a {
    display: inline-block;
    padding: var(--space-1) var(--space-3);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    color: var(--color-text);
    text-decoration: none;
    margin: 0 2px;
    font-size: 13px;
    transition: background 0.1s;
}

.pages a:hover {
    background: var(--color-surface-raised);
    color: var(--color-primary);
}
```

---

### TASK-TABLE-07: `td table` nested tables

Nested tables appear inside edit forms (fieldsets with multiple inputs per cell). Keep existing `width: 100%; margin: 0`:

```css
td table {
    width: 100%;
    margin: 0;
    border: none;
    box-shadow: none;
}

td table td,
td table th {
    border: none;
    background: none;
    padding: var(--space-1) var(--space-2);
}
```

---

### TASK-TABLE-08: Time display (`.time`)

```css
.time {
    color: var(--color-muted);
    font-size: 11px;
}
```

---

## Acceptance Criteria

- [ ] `.checkable` row selection (JS toggle `.checked`) still works visually
- [ ] `thead position: sticky; top: 0` preserved
- [ ] `.js .column` absolute overlay for hover menu still renders over cells
- [ ] `td.nowrap` / `.nowrap td` pre-wrap behavior preserved
- [ ] `.scrollable` horizontal scroll still works
- [ ] Sorting links in `thead th a` still visible
- [ ] Checkbox in header (`#check-all`) still functional
- [ ] No PHP files modified

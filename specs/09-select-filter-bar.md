# Spec: Select / Browse Screen — Filter & Action Bar

**Priority:** 9  
**Risk:** High — filter form drives SQL WHERE/ORDER/LIMIT; all field names are query parameters  
**Screen:** `select.inc.php`  
**PHP source:** `Adminer::selectColumnsPrint()`, `selectSearchPrint()`, `selectOrderPrint()`, `selectLimitPrint()`, `selectLengthPrint()`, `selectActionPrint()` in `adminer/include/adminer.inc.php`

---

## Goal

Improve the visual appearance of the collapsible filter/sort/limit fieldsets above the data table. Keep all form inputs and their names intact.

---

## Current HTML Structure

```html
<form id="form" action="" method="get">
  <!-- Hidden: driver, username, db, token, select (table name) -->

  <!-- Fieldsets — each is collapsible via JS toggle -->
  <fieldset>
    <legend><a href="#fieldset-select">Select</a></legend>
    <div id="fieldset-select" class="hidden">
      <!-- Column pickers: columns[N][fun], columns[N][col] -->
    </div>
  </fieldset>

  <fieldset>
    <legend><a href="#fieldset-search">Search</a></legend>
    <div id="fieldset-search" class="hidden">
      <!-- where[N][col], where[N][op], where[N][val] -->
    </div>
  </fieldset>

  <fieldset>
    <legend><a href="#fieldset-sort">Sort</a></legend>
    <div id="fieldset-sort" class="hidden">
      <!-- order[N], desc[N] -->
    </div>
  </fieldset>

  <fieldset>
    <legend>Limit</legend>
    <div>
      <input type="number" name="limit" class="size" value="50">
    </div>
  </fieldset>

  <fieldset>
    <legend>Action</legend>
    <div>
      <input type="submit" value="Select">
      <span id="noindex" title="Full table scan"></span>
    </div>
  </fieldset>

</form>
```

**Critical form fields:** `columns[N][fun]`, `columns[N][col]`, `where[N][col]`, `where[N][op]`, `where[N][val]`, `fulltext[N]`, `boolean[N]`, `order[N]`, `desc[N]`, `limit`, `text_length`, `page`.

---

## Tasks

### TASK-SELECT-01: Fieldset container styling

```css
/* The filter fieldsets sit in a horizontal strip */
fieldset {
    display: inline-block;
    vertical-align: top;
    padding: var(--space-3) var(--space-4);
    margin: 0 var(--space-3) var(--space-3) 0;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    background: var(--color-surface);
    box-shadow: var(--shadow-sm);
}

fieldset legend {
    font-size: 12px;
    font-weight: 600;
    color: var(--color-muted);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 0 var(--space-2);
}

fieldset legend a {
    color: var(--color-muted);
    text-decoration: none;
    cursor: pointer;
}

fieldset legend a:hover {
    color: var(--color-primary);
}

/* Sticky footer fieldset group */
.footer fieldset {
    margin-top: 0;
    box-shadow: none;
    background: none;
}
```

---

### TASK-SELECT-02: Fieldset inner div (row of controls)

Each collapsible fieldset has a `<div id="fieldset-*">` child. Each row inside is a `<div>` with selects/inputs:

```css
fieldset > div {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-2);
    align-items: center;
}

/* Each row in search/sort/columns boxes */
fieldset > div > div {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    margin-bottom: var(--space-1);
}
```

---

### TASK-SELECT-03: `.size` inputs (limit / text_length)

```css
input.size {
    width: 7ex;
    text-align: right;
    padding: var(--space-1) var(--space-2);
}
```

---

### TASK-SELECT-04: "No index" warning indicator

```css
#noindex {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: transparent;
    transition: background 0.2s;
}

/* JS sets title when no index is used — visual hint only */
#noindex[title]:not([title=""]) {
    background: var(--color-error-text);
    cursor: help;
}
```

---

### TASK-SELECT-05: Action bar below data table (`.footer`)

The sticky footer below the table contains checkboxes, bulk-action buttons, and export form. This area uses `<fieldset>` elements with class `.footer`.

```css
/* Already covered in TASK-BTN-05, extend for select page specifics: */
.footer fieldset legend {
    font-size: 12px;
    color: var(--color-muted);
}

/* Bulk actions: Clone, Delete selected, etc. */
.footer input[type="submit"] {
    font-size: 13px;
    padding: var(--space-1) var(--space-3);
}
```

---

### TASK-SELECT-06: Links bar above the table (`.links`)

```css
p.links {
    margin: 0 0 var(--space-4);
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-3);
    align-items: center;
    font-size: 13px;
}

p.links a {
    color: var(--color-primary);
    text-decoration: none;
    padding: var(--space-1) var(--space-2);
    border-radius: var(--radius-sm);
    transition: background 0.1s;
}

p.links a:hover {
    background: var(--color-surface-raised);
    text-decoration: none;
}

p.links a.active {
    font-weight: 600;
    background: var(--lit);
}
```

---

## Acceptance Criteria

- [ ] All `columns[*]`, `where[*]`, `order[*]`, `desc[*]`, `limit`, `text_length` fields present
- [ ] `form#form` GET action preserved (no `method="post"` added)
- [ ] Fieldset collapse/expand (JS `toggle('fieldset-*')`) still works (`.hidden` class)
- [ ] `#noindex` element present for JS to populate `title`
- [ ] `selectFieldChange` JS handler still fires on input changes (drives auto-submit)
- [ ] `selectAddRow` JS handler still fires on last row select change (adds new row)
- [ ] No PHP files modified

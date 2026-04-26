# Spec: Table Structure & Schema Screens

**Priority:** 10  
**Risk:** Low–Medium — mostly display tables with some action forms  
**Screens:** `table.inc.php` (structure), `create.inc.php` (alter table), `indexes.inc.php`, `foreign.inc.php`, `schema.inc.php`  
**PHP source:** `Adminer::tableStructurePrint()`, `Adminer::tableIndexesPrint()` in `adminer/include/adminer.inc.php`

---

## Goal

Make table structure, indexes, and foreign key screens more readable. Improve the column editor form in create/alter table.

---

## Screen: Table Structure (`table.inc.php`)

### Current HTML (from `tableStructurePrint()`)

```html
<div class="scrollable">
  <table class="nowrap odds">
    <thead>
      <tr><th>Column<td>Type<td>Comment (if supported)
    </thead>
    <tr>
      <th>column_name
      <td><span title="collation">type [NULL] [Auto Increment] [default]</span>
      <td>comment text
    </tr>
    ...
  </table>
</div>
```

### Tasks

#### TASK-STRUCT-01: Structure table column widths

```css
/* Column name column */
.nowrap.odds th:first-child {
    min-width: 150px;
    font-weight: 500;
    color: var(--color-text);
}

/* Type column */
.nowrap.odds td:first-child {
    font-family: var(--font-mono);
    font-size: 12px;
    color: var(--color-muted);
}

/* NULL / Auto Increment / default value styling */
.nowrap.odds td i {
    color: var(--color-muted);
    font-style: normal;
    font-size: 11px;
    background: var(--color-surface-raised);
    border: 1px solid var(--color-border);
    border-radius: 3px;
    padding: 1px 4px;
    margin-left: 4px;
}

/* Default value badge */
.nowrap.odds td b {
    font-weight: normal;
    font-family: var(--font-mono);
    font-size: 11px;
    color: var(--color-primary);
}
```

---

## Screen: Alter Table / Create Table (`create.inc.php`)

### Current HTML structure

The create/alter table form uses `<table id="edit-fields">` (same ID as the row edit form, but different content structure):

```html
<form method="post">
  <table id="edit-fields">
    <!-- Each row is a column definition:
         name, type, length, options (NULL, auto_increment, default...) -->
  </table>
  <p>
    <input type="submit" value="Save" name="create" class="default">
  </p>
</form>
```

The column definition inputs have names like `fields[N][field]`, `fields[N][type]`, `fields[N][length]`, `fields[N][null]`, etc. These must not change.

#### TASK-STRUCT-02: Column editor table

```css
/* Reuse #edit-fields rules from TASK-EDIT-01 */
/* Additional create-table specific: type select should be compact */
#edit-fields select[name*="[type]"] {
    min-width: 120px;
    font-family: var(--font-mono);
    font-size: 12px;
}

/* Length/precision input */
#edit-fields input[name*="[length]"] {
    width: 8ex;
    text-align: right;
}

/* Options column: NULL checkbox, AI checkbox, etc. */
#edit-fields td:last-child label {
    white-space: nowrap;
    font-size: 12px;
    color: var(--color-muted);
}
```

---

## Screen: Indexes (`indexes.inc.php`)

### Current HTML

```html
<form method="post">
  <table>
    <thead>
      <tr><th>Name<th>Type<th>Column<th>(actions)
    </thead>
    <!-- Existing indexes and new index form rows -->
  </table>
  <p>
    <input type="submit" value="Save" name="indexes" class="default">
  </p>
</form>
```

#### TASK-STRUCT-03: Index table

No specific additions beyond the base table styles. Ensure the column picker `<select>` elements inside the table are readable:

```css
/* Column picker selects in index rows */
table select[name*="[columns]"] {
    min-width: 120px;
}
```

---

## Screen: ER Diagram (`schema.inc.php`)

The schema screen renders `<div id="schema">` with absolutely positioned `<div class="table">` elements connected by `<svg class="references">`.

This screen uses mouse drag (JS). CSS changes should be minimal — only improve the table card appearance:

#### TASK-STRUCT-04: Schema table cards

```css
#schema {
    margin-left: 60px;
    position: relative;
    user-select: none;
}

#schema .table {
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    padding: 0;
    cursor: move;
    position: absolute;
    background: var(--color-surface);
    box-shadow: var(--shadow-sm);
    min-width: 140px;
    font-size: 12px;
}

#schema .table a {
    display: block;
    padding: var(--space-1) var(--space-3);
    color: var(--color-text);
    text-decoration: none;
    border-bottom: 1px solid var(--color-border);
}

#schema .table a:last-child {
    border-bottom: none;
}

#schema .table a:first-child {
    font-weight: 600;
    background: var(--color-surface-raised);
    border-radius: var(--radius-sm) var(--radius-sm) 0 0;
    border-bottom: 2px solid var(--color-border);
}

#schema .table a:hover {
    background: var(--color-surface-raised);
    color: var(--color-primary);
}
```

---

## Acceptance Criteria

- [ ] All `fields[N][*]` column definition inputs present
- [ ] `name="create"` save button present
- [ ] `name="indexes"` save button present
- [ ] Schema drag-and-drop JS still works
- [ ] `.references` SVG arrows still render
- [ ] No PHP files modified

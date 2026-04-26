# Spec: Export, Import & Dump Screens

**Priority:** 11  
**Risk:** Low — these are mostly forms with radio/checkbox groups  
**Screens:** `dump.inc.php` (Export), `sql.inc.php` import section  
**PHP source:** `Adminer::dumpOutput()`, `Adminer::dumpFormat()`, `Adminer::dumpHeaders()`

---

## Goal

Clean up the export/import forms. Improve grouping of options, spacing, and the action buttons.

---

## Export Screen (`dump.inc.php`) — Current HTML

```html
<h2>Export</h2>

<form action="" method="post" id="dump">

  <fieldset>
    <legend>Output</legend>
    <div>
      <!-- radio: name="output" values: text, file, gz -->
    </div>
  </fieldset>

  <fieldset>
    <legend>Format</legend>
    <div>
      <!-- radio: name="format" values: sql, csv, csv;, tsv -->
    </div>
  </fieldset>

  <!-- Database / table options (varies by context) -->

  <p>
    <input type="submit" value="Export" name="export" class="default">
  </p>

</form>
```

**Critical fields:** `name="output"`, `name="format"`, `name="export"`, `name="token"`. Also `name="tables[]"`, `name="views[]"`, `name="data[]"` when exporting multiple tables.

---

## Import Section — Current HTML (inside `sql.inc.php`)

```html
<!-- Import tab (triggered by ?import=) -->
<form action="" method="post" enctype="multipart/form-data">
  <p>
    <input type="file" name="sql_file[]">
    <!-- or server-side path input: <input name="webfile" value="adminer.sql"> -->
  </p>
  <p>
    <label>
      <input type="checkbox" name="error_stops" ...> Stop on error
    </label>
    <label>
      <input type="checkbox" name="only_errors" ...> Show only errors
    </label>
    <input type="submit" value="Execute" name="sql">
    <input type="hidden" name="token" ...>
  </p>
</form>
```

---

## Tasks

### TASK-DUMP-01: Export fieldset groups

```css
/* Side-by-side fieldsets for Output + Format */
#dump fieldset {
    display: inline-block;
    vertical-align: top;
    min-width: 160px;
    margin: 0 var(--space-4) var(--space-4) 0;
    padding: var(--space-3) var(--space-4);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    background: var(--color-surface);
}

#dump fieldset legend {
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    color: var(--color-muted);
    padding: 0 var(--space-2);
}
```

---

### TASK-DUMP-02: Radio/checkbox option lists

```css
/* Each radio/checkbox option in dump fieldsets */
#dump label {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    padding: var(--space-1) 0;
    font-size: 13px;
    cursor: pointer;
    color: var(--color-text);
}

#dump label:hover {
    color: var(--color-primary);
}
```

---

### TASK-DUMP-03: Table selection list

When exporting from the database screen, a table of checkboxes is shown. This uses the standard `.checkable` table — covered by TASK-TABLE-03. No additional work needed.

---

### TASK-DUMP-04: Import file input

```css
/* File input styling */
input[type="file"] {
    font-size: 13px;
    color: var(--color-muted);
}
```

---

## Acceptance Criteria

- [ ] `name="output"` radios present
- [ ] `name="format"` radios present
- [ ] `name="export"` submit button present
- [ ] `name="token"` hidden input present
- [ ] `name="sql_file[]"` file input present on import
- [ ] `enctype="multipart/form-data"` on import form preserved
- [ ] No PHP files modified

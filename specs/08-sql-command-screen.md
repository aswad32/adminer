# Spec: SQL Command Screen

**Priority:** 8  
**Risk:** Medium — textarea and execution form must be preserved exactly  
**Screen:** `sql.inc.php`  
**PHP source:** `sql.inc.php`, `Adminer::sqlPrintAfter()`, `Adminer::sqlCommandQuery()`

---

## Goal

Improve the SQL command screen layout: larger, cleaner editor area, clearer action buttons, better result display.

---

## Current HTML Structure

```html
<h2>SQL command</h2>

<form id="form" action="" method="post">
  <!-- Hidden fields: token, db, limit, error_stops, only_errors -->

  <p>
    <textarea name="sql" id="sql" class="sqlarea jush-sql" ...>
      <!-- current SQL -->
    </textarea>
  </p>

  <!-- Syntax help popup anchor -->
  <p id="help-links">
    <a href="...">Help</a>
    ...
  </p>

  <!-- adminer()->sqlPrintAfter() output here -->

  <p>
    <input type="submit" value="Execute" name="sql">
    <label>
      <input type="checkbox" name="error_stops" ...> Stop on error
    </label>
    <label>
      <input type="checkbox" name="only_errors" ...> Show only errors
    </label>
  </p>
</form>

<!-- Query history -->
<div id="history">...</div>

<!-- Results (tables / messages) rendered below form -->
```

**Critical fields:** `name="sql"` (textarea), `name="error_stops"`, `name="only_errors"`, `name="limit"`, `name="token"`. The submit button also has `name="sql"` — it must be preserved.

---

## Tasks

### TASK-SQL-01: SQL textarea

```css
.sqlarea {
    width: 100%;
    min-height: 180px;
    box-sizing: border-box;
    font-family: var(--font-mono);
    font-size: 13px;
    line-height: 1.6;
    padding: var(--space-3) var(--space-4);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    background: var(--color-surface);
    color: var(--color-text);
    resize: vertical;
}

.sqlarea:focus {
    outline: 2px solid var(--color-primary);
    outline-offset: -1px;
    border-color: var(--color-primary);
}

/* SQL highlight is applied by jush to .jush-sql */
pre.jush {
    background: var(--color-surface-raised);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    padding: var(--space-3) var(--space-4);
    font-family: var(--font-mono);
    font-size: 13px;
    overflow-x: auto;
}
```

---

### TASK-SQL-02: SQL form footer

```css
/* Action bar below textarea */
.sql-footer {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: var(--space-4);
    margin: var(--space-3) 0 var(--space-5);
    padding-bottom: var(--space-5);
    border-bottom: 1px solid var(--color-border);
}

.sql-footer label {
    display: inline-flex;
    align-items: center;
    gap: var(--space-2);
    font-size: 13px;
    color: var(--color-muted);
    cursor: pointer;
}
```

---

### TASK-SQL-03: Query result display

After execution, SQL results are shown as a `<table>` (normal data table rules apply) or as a `.message` / `.error` div. The query itself is shown via `Adminer::selectQuery()` output which wraps in `<p><code class="jush-...">`:

```css
/* Query display above result */
p > code.jush-sql,
p > code[class^="jush-"] {
    display: inline-block;
    font-family: var(--font-mono);
    font-size: 12px;
    background: var(--color-surface-raised);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    padding: var(--space-1) var(--space-2);
    max-width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    vertical-align: middle;
}
```

---

### TASK-SQL-04: Query history panel

```css
#history {
    margin-top: var(--space-5);
    padding-top: var(--space-4);
    border-top: 1px solid var(--color-border);
}

/* Each history entry toggle */
#history a.toggle {
    font-size: 13px;
    color: var(--color-primary);
    cursor: pointer;
    text-decoration: none;
}

#history a.toggle:hover {
    text-decoration: underline;
}

/* Collapsed SQL blocks */
#history .hidden {
    display: none;
}

#history pre code {
    display: block;
    font-family: var(--font-mono);
    font-size: 12px;
    padding: var(--space-3);
    background: var(--color-surface-raised);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    overflow-x: auto;
    white-space: pre;
}
```

---

## Acceptance Criteria

- [ ] `<textarea name="sql">` present with correct `name` and `id="sql"`
- [ ] `name="error_stops"`, `name="only_errors"`, `name="limit"` checkboxes present
- [ ] `<input type="submit" name="sql">` Execute button present
- [ ] Hidden `name="token"` present
- [ ] SQL syntax highlighting (jush) still loads and applies
- [ ] Autocomplete still works (jush-autocomplete-sql)
- [ ] History toggle (`#sql-N` anchors) still functions
- [ ] No PHP files modified

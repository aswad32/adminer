# Spec: Insert / Edit Row Form

**Priority:** 7  
**Risk:** High — form fields directly drive INSERT/UPDATE queries; fieldnames and function selects must not change  
**Screen:** `edit.inc.php` (Insert / Edit row)  
**PHP source:** `input()` in `adminer/include/html.inc.php`; `Adminer::editInput()`, `Adminer::editFunctions()`, `Adminer::editRowPrint()` in `adminer/include/adminer.inc.php`

---

## Goal

Improve readability of the insert/edit form. Each field row has: a column name, a function selector, and an input. These should be clearly aligned and easy to scan.

---

## Current HTML Structure

The edit form uses a `<table id="edit-fields">` structure:

```html
<form method="post" id="form-edit">
  <table id="edit-fields">
    <thead>
      <tr>
        <th>Column</th>
        <th>Function</th>
        <th>Value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th>field_name</th>
        <td class="function">
          <select name="function[field_name]">...</select>
          <!-- OR plain text function name -->
        </td>
        <td>
          <input name="fields[field_name]" value="...">
          <!-- OR <textarea> / <select> for enum / <input type="file"> -->
        </td>
      </tr>
      ...
    </tbody>
  </table>

  <p>
    <input type="submit" value="Save" name="save" class="default">
    <input type="submit" value="Save and continue edit" name="insert">
    <input type="submit" value="Delete" name="delete">
    <!-- hidden: token, referer, where[...] -->
  </p>
</form>
```

**Critical:** `name="fields[field_name]"`, `name="function[field_name]"`, `name="save"`, `name="insert"`, `name="delete"` must not change.

### `input()` function output (html.inc.php)

The `input()` function outputs:
1. `<td class="function">` with function selector (or plain text)
2. `<td>` with the actual input (`<input>`, `<textarea>`, `<select>`, radio/checkbox enum)

The `<tr>` and first `<th>` (column name) are rendered by `edit.inc.php`.

---

## Tasks

### TASK-EDIT-01: Edit table layout

```css
#edit-fields {
    width: 100%;
    max-width: 900px;
    border-collapse: collapse;
    margin: 0 0 var(--space-5);
}

#edit-fields th,
#edit-fields td {
    padding: var(--space-2) var(--space-3);
    border: 1px solid var(--color-border);
    vertical-align: middle;
}

#edit-fields thead th {
    font-size: 11px;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    font-weight: 600;
    color: var(--color-muted);
    background: var(--color-surface-raised);
    white-space: nowrap;
}

#edit-fields tbody tr:hover td,
#edit-fields tbody tr:hover th {
    background: var(--dim);
}

/* Column name cell */
#edit-fields tbody th {
    font-weight: 500;
    font-size: 13px;
    color: var(--color-text);
    background: var(--color-surface-raised);
    white-space: nowrap;
    min-width: 120px;
    max-width: 200px;
}
```

---

### TASK-EDIT-02: Function column

```css
/* The <td class="function"> holds the function selector */
#edit-fields td.function {
    text-align: right;
    white-space: nowrap;
    width: 14em;
    color: var(--color-muted);
    font-size: 12px;
}

#edit-fields td.function select {
    font-size: 12px;
    color: var(--color-muted);
    border-color: var(--color-border);
    background: var(--color-surface);
    max-width: 12em;
}
```

---

### TASK-EDIT-03: Input cells

```css
/* Value input cell — full width inputs */
#edit-fields tbody td:last-child {
    width: 100%;
}

#edit-fields tbody td:last-child input[type="text"],
#edit-fields tbody td:last-child input[type="number"],
#edit-fields tbody td:last-child textarea {
    width: 100%;
    min-width: 240px;
}

#edit-fields textarea {
    font-family: var(--font-mono);
    font-size: 13px;
    resize: vertical;
    min-height: 80px;
}
```

---

### TASK-EDIT-04: Enum / set radio+checkbox

```css
/* Enum input radio/checkbox labels */
#edit-fields label {
    display: inline-flex;
    align-items: center;
    gap: var(--space-1);
    margin-right: var(--space-3);
    font-size: 13px;
    cursor: pointer;
}
```

---

### TASK-EDIT-05: Form action buttons

```css
/* The <p> after the edit table contains Save / Save and continue / Delete */
#form-edit > p,
form > p.submit {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-3);
    align-items: center;
    margin-top: var(--space-4);
    padding-top: var(--space-4);
    border-top: 1px solid var(--color-border);
}
```

---

## Field Types Reference (PHP → HTML)

| Field type | Input rendered |
|---|---|
| enum | `<input type="radio">` per option |
| set | `<input type="checkbox">` per option |
| JSON / jsonb | `<textarea class="jush-js">` |
| TEXT / BLOB | `<textarea>` |
| boolean | `<input type="hidden">` + `<input type="checkbox">` |
| integer | `<input type="number">` |
| file upload | `<input type="file">` |
| other | `<input>` (text) |

---

## Acceptance Criteria

- [ ] All `name="fields[*]"` inputs present
- [ ] All `name="function[*]"` selects present  
- [ ] `name="save"`, `name="insert"`, `name="delete"` buttons present
- [ ] Hidden fields (`name="token"`, `name="referer"`, `name="where[*]"`) untouched
- [ ] `autofocus` attribute on first field preserved
- [ ] Textarea for JSON/TEXT types renders correctly
- [ ] Enum radio group renders correctly
- [ ] File upload input present when applicable
- [ ] No PHP files modified

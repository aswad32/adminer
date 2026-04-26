# Spec: Sidebar Navigation

**Priority:** 4  
**Risk:** Medium — sidebar JS interactions must be preserved  
**Screen:** All post-login screens  
**PHP source:** `Adminer::navigation()`, `Adminer::tablesPrint()`, `Adminer::databasesPrint()` in `adminer/include/adminer.inc.php`

---

## Goal

Improve readability and visual hierarchy of the left sidebar: the table list (`#tables`), database list (`#dbs`), and action links (`p.links`).

---

## Current Structure (inside `#menu`)

```html
<h1>  ← logo + version (TASK-LAYOUT-02 handles this)

<!-- Login page: session list -->
<ul id="logins">
  <li><a href="...">...</a>
  ...
</ul>

<!-- Post-login: database list -->
<div id="dbs">
  ...
</div>

<!-- Post-login: action links -->
<p class="links">
  <a href="?...sql=">SQL command</a>
  <a href="?...import=">Import</a>
  <a href="?...dump=...">Export</a>
  <a href="?...create=">Create table</a>
</p>

<!-- Table list -->
<ul id="tables">
  <li><a href="?...select=tablename">tablename</a>
  ...
</ul>
```

**Important:** `#tables` uses JS events: `onmouseover: menuOver, onmouseout: menuOut` (from `functions.js`). The table name `<a>` elements are wrapped by JS for hover menus. Do not change the `<ul>` / `<li>` / `<a>` structure.

`#dbs` is also populated dynamically by AJAX (`functions.js: fillDbs()`). Structure must be preserved.

---

## Current CSS for nav

```css
#menu { position: absolute; margin: 10px 0 0; top: 2em; left: 0; width: 19em; }
#menu p, #logins, #tables { padding: .8em 1em; margin: 0; border-bottom: 1px solid #ccc; }
#logins li, #tables li { list-style: none; }
#dbs { overflow: hidden; }
#logins, #tables { white-space: nowrap; overflow: hidden; }
#logins a, #tables a, #tables span { background: var(--bg); }
.active { font-weight: bold; }
```

---

## Tasks

### TASK-NAV-01: Table list items

Modernize list item styles. Do not change HTML structure.

```css
#tables {
    white-space: nowrap;
    overflow: hidden;
    padding: var(--space-2) 0;
    margin: 0;
    border-bottom: 1px solid var(--color-border);
}

#tables li {
    list-style: none;
}

#tables a,
#tables span {
    display: block;
    padding: var(--space-1) var(--space-4);
    font-size: 13px;
    color: var(--color-text);
    text-decoration: none;
    background: var(--color-surface); /* keep for JS column overlay */
    border-radius: 0;
    transition: background 0.1s;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

#tables a:hover {
    background: var(--color-surface-raised);
    color: var(--color-primary);
    text-decoration: none;
}

#tables .active {
    font-weight: 600;
    color: var(--color-primary);
    background: var(--lit);
}
```

---

### TASK-NAV-02: Sidebar action links

The `<p class="links">` inside `#menu` contains SQL command / Import / Export / Create table links.

```css
#menu .links {
    padding: var(--space-3) var(--space-4);
    margin: 0;
    border-bottom: 1px solid var(--color-border);
    display: flex;
    flex-direction: column;
    gap: var(--space-1);
}

#menu .links a {
    display: block;
    padding: var(--space-2) var(--space-3);
    font-size: 13px;
    color: var(--color-text);
    border-radius: var(--radius-sm);
    text-decoration: none;
    transition: background 0.1s;
    white-space: nowrap;
}

#menu .links a:hover {
    background: var(--color-surface-raised);
    color: var(--color-primary);
}

#menu .links a.active {
    font-weight: 600;
    color: var(--color-primary);
    background: var(--lit);
}
```

**Note:** The `bold()` PHP function adds `class='active'` to the current page's link. This relies on the class name `active` — do not rename it.

---

### TASK-NAV-03: Database list (`#dbs`)

`#dbs` is populated by `databasesPrint()`. Its inner structure varies by driver. Apply conservative styling only:

```css
#dbs {
    overflow: hidden;
    padding: var(--space-2) 0;
    border-bottom: 1px solid var(--color-border);
    font-size: 13px;
}
```

---

### TASK-NAV-04: Language switcher (`#lang`)

```css
#lang {
    position: absolute;
    top: -2.6em;
    left: 0;
    padding: var(--space-1) var(--space-3);
    font-size: 12px;
}

#lang select {
    font-size: 12px;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    background: var(--color-surface);
    color: var(--color-text);
    padding: 2px var(--space-2);
}
```

---

### TASK-NAV-05: Mobile hamburger button (`#menuopen`)

```css
#menuopen {
    display: none; /* shown by media query */
    position: absolute;
    top: 3px;
    left: 6px;
    cursor: pointer;
    padding: var(--space-2);
    border-radius: var(--radius-sm);
    transition: background 0.15s;
}

#menuopen:hover {
    background: var(--color-surface-raised);
}
```

---

## Acceptance Criteria

- [ ] `#tables` `<ul>`/`<li>`/`<a>` structure unchanged
- [ ] `#dbs` structure unchanged
- [ ] JS mouse hover menus still function (`.column` absolute overlay)
- [ ] `.active` class still produces visual active state
- [ ] Mobile sidebar toggle (`#foot` / `.foot` CSS class swap) still works
- [ ] No PHP files modified

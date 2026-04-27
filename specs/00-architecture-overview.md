# Adminer UI Architecture Overview

## Purpose

This document maps the files and functions responsible for generating HTML output in Adminer. It is the reference for all UI modernization work. **Do not change behavior — only change appearance.**

---

## Request Routing

All requests enter through `adminer/index.php`, which dispatches to a specific `*.inc.php` page based on `$_GET` parameters.

| `$_GET` key | File loaded | Screen |
|---|---|---|
| _(none)_ | `db.inc.php` | Database / table list |
| `select` | `select.inc.php` | Browse table rows |
| `edit` | `edit.inc.php` | Insert / edit row |
| `table` | `table.inc.php` | Table structure |
| `create` | `create.inc.php` | Alter/create table |
| `indexes` | `indexes.inc.php` | Index management |
| `sql` | `sql.inc.php` | SQL command |
| `dump` | `dump.inc.php` | Export |
| `privileges` | `privileges.inc.php` | User privileges |
| `schema` | `schema.inc.php` | ER diagram |
| `database` | `database.inc.php` | Alter database |
| `call` / `callf` | `call.inc.php` | Stored procedure call |
| `foreign` | `foreign.inc.php` | Foreign key editor |
| `view` | `view.inc.php` | View editor |
| `procedure` / `function` | `procedure.inc.php` | Routine editor |
| `trigger` | `trigger.inc.php` | Trigger editor |
| `event` | `event.inc.php` | Event editor |
| `type` | `type.inc.php` | User-defined type editor |
| `user` | `user.inc.php` | User management |
| `processlist` | `processlist.inc.php` | Process list |
| `variables` | `variables.inc.php` | Server variables |
| `sequence` | `sequence.inc.php` | Sequence editor |
| `check` | `check.inc.php` | Check constraint editor |

Every page file calls `page_header()` at the top and relies on `page_footer()` being called at the bottom of `index.php`.

---

## HTML Shell — The Two Functions That Wrap Every Screen

### `page_header()` — `adminer/include/design.inc.php`

Outputs:
- Full `<!DOCTYPE html>` preamble, `<head>`, CSS links, JS links
- `<body>` opening with classes (`ltr`, `nojs`, `adminer`, etc.)
- `<div id="content">` wrapper
- `#menuopen` hamburger button (mobile only)
- `<p id="breadcrumb">` navigation trail
- `<h2>` page title
- Flash / error message divs (`.message`, `.error`)

### `page_footer()` — `adminer/include/design.inc.php`

Outputs:
- Closing `</div>` for `#content`
- `<div id="foot">` containing:
  - `<div id="menu">` — sidebar navigation (rendered by `navigation()`)
  - Logout `<form>` with username display and `<input type="submit" name="logout">`

---

## CSS Files

| File | Role |
|---|---|
| `adminer/static/default.css` | Main stylesheet (light mode + layout) |
| `adminer/static/dark.css` | Dark mode overrides |
| `externals/jush/jush.css` | Syntax highlight (light) |
| `externals/jush/jush-dark.css` | Syntax highlight (dark) |
| `adminer.css` / `adminer-dark.css` | Optional per-deployment custom CSS (loaded via `Adminer::css()`) |

CSS is loaded from `Adminer::head()` and `page_header()`. The active color scheme is determined by `adminer()->css()` and whether `prefers-color-scheme: dark` is referenced in the custom CSS.

---

## JavaScript Files

| File | Role |
|---|---|
| `adminer/static/functions.js` | Core utilities: DOM helpers (`qs`, `qsl`, `qsa`), `mixin`, `toggle`, `cookie`, AJAX helpers |
| `adminer/static/editing.js` | Form behavior: file uploads, field change handlers, select-table click, inline edit |

No large JS framework is used. All interactivity is hand-rolled vanilla JS.

---

## CSS Variable System (current)

The existing stylesheet uses four CSS variables defined on `html {}`:

```css
--bg    /* page background */
--fg    /* foreground text */
--dim   /* dimmed surface (header, table headers, hover) */
--lit   /* highlighted surface (breadcrumb, thead, focus target) */
```

These are minimal and must be kept. Modernization should expand this system with new variables without removing these four.

---

## Key HTML IDs and Classes (do not rename)

These IDs and classes are referenced by PHP logic, existing JavaScript, or designs:

| Selector | Used by |
|---|---|
| `#content` | Layout: main area offset from sidebar |
| `#foot` | Layout: sidebar + footer container |
| `#menu` | Navigation sidebar |
| `#menuopen` | Mobile hamburger toggle |
| `#breadcrumb` | Navigation breadcrumb |
| `#logins` | Login session list in sidebar |
| `#tables` | Table list in sidebar |
| `#dbs` | Database list in sidebar |
| `#help` | Inline SQL help popup |
| `#ajaxstatus` | AJAX loading indicator |
| `#logout` | Logout submit button |
| `.message` | Success flash messages |
| `.error` | Error messages |
| `.hidden` | JS show/hide toggle |
| `.jsonly` | Shown only when JS is active |
| `.nojs` | Shown only without JS |
| `.active` | Active nav item (bold) |
| `.links` | Action link bar under headings |
| `.nowrap` | Table with no-wrap cells |
| `.checkable` | Selectable table rows |
| `.checked` | Selected row highlight |
| `.odds` | Alternating row colors |
| `.scrollable` | Horizontally scrollable table wrapper |
| `.footer` | Sticky bottom action bar in select |
| `.icon` | Icon buttons (background-image based) |
| `.function` | Right-aligned function select cell in edit form |
| `.sqlarea` | Full-width SQL textarea |
| `.layout` | Login form table |
| `form#form` | Main select/search form |

---

## JS-Locked Elements — Never Restructure

These elements have hardcoded positions or IDs referenced by JS. Wrapping them in a way that changes their DOM position, or changing their tag, will break functionality:

| Element | JS dependency | Why it breaks |
|---|---|---|
| `<table class="layout">` rows | `loginDriver()` — `parentTag(driver, 'table').rows[1]` | Server row index is hardcoded to `.rows[1]`; inserting a row above it shifts the index |
| `#foot > #menu` | `menuOpen` — toggles `foot` class on `#foot` | `#menu` must be a direct child of `#foot`; intermediate wrapper breaks the selector |
| `<form id="form">` | JS assigns `.onsubmit` by ID | Handler binds directly to this form element |
| `<table id="table">` | `selectLoadMore` — appends `<tbody>` rows via direct DOM reference | Adding tables before it confuses `qsl('table')` last-table selector |
| `<table id="edit-fields">` | `columnShow()` — hides `<td>` by index position | TD index positions are hardcoded; adding a column before shifts all indices |
| `<span id="selected">` inside `<legend>` | `selectCount()` — traverses `.parentNode.parentNode` | The span must remain exactly 2 levels deep from the fieldset's submit buttons |

---

## PHP UI Methods — Safe to Modify

These methods may receive additive HTML wrapper elements (new `<div>` wrappers, headings, or semantic containers **around** existing output). Existing elements, IDs, classes, and output order must not change.

| Method | File | Safe additions |
|---|---|---|
| `loginForm()` | `adminer/include/adminer.inc.php` | Add content before `<table class='layout'>` — the table itself and its rows must stay unchanged |
| `navigation()` | `adminer/include/adminer.inc.php` | Add wrapper `<div>` around logical groups; existing `<h1>`, `#logins`, `#tables` stay as-is |
| `tablesPrint()` | `adminer/include/adminer.inc.php` | Add outer wrapper around `<ul id='tables'>` |
| `page_header()` | `adminer/include/design.inc.php` | Add `<div class="topbar">` wrapping `#menuopen` + `#breadcrumb`; add message wrapper |
| `page_footer()` | `adminer/include/design.inc.php` | Must keep `#foot > #menu` direct hierarchy |
| `auth_error()` | `adminer/include/auth.inc.php` | Add wrapper and heading elements around the `<form>` |

---

## Editor Mirror Rule

The file `adminer/include/adminer.inc.php` contains this comment at the top:

```
// any method change in this file should be transferred to editor/include/adminer.inc.php
```

**This must be followed for all UI changes.** Every structural addition made to a method in `adminer/include/adminer.inc.php` must be identically applied to the corresponding method in `editor/include/adminer.inc.php`. The editor variant may override some methods; apply the equivalent wrapper addition there too.

# Spec: Login Screen

**Priority:** 2  
**Risk:** Low — CSS wrapper only, no PHP form field changes  
**Screen:** Login page (no `db` or `username` in URL)  
**PHP entry:** `adminer/include/connect.inc.php` → `Adminer::loginForm()` in `adminer/include/adminer.inc.php`

---

## Goal

Modernize the login screen layout. Present a clean centered card with clear field labels, a styled submit button, and the Adminer logo/name at the top.

---

## Current State

The login form is rendered by `Adminer::loginForm()`:

```php
function loginForm(): void {
    echo "<table class='layout'>\n";
    // rows: driver, server, username, password, db
    echo "</table>\n";
    echo "<p><input type='submit' value='" . lang('Login') . "'>\n";
    echo checkbox("auth[permanent]", 1, ..., lang('Permanent login')) . "\n";
}
```

The outer form is wrapped in a `<form method="post">` in `connect.inc.php`. The `page_header()` function still renders the breadcrumb and `#content` wrapper.

The login form fields use `name="auth[driver]"`, `name="auth[server]"`, `name="auth[username]"`, `name="auth[password]"`, `name="auth[db]"`. These names must not change.

---

## Current HTML structure

```html
<div id="content">
  <!-- breadcrumb, h2 omitted on login -->
  <form method="post">
    <table class="layout">
      <tr><th>System<td><select name="auth[driver]">...</select>
      <tr><th>Server<td><input name="auth[server]">
      <tr><th>Username<td><input name="auth[username]">
      <tr><th>Password<td><input type="password" name="auth[password]">
      <tr><th>Database<td><input name="auth[db]">
    </table>
    <p><input type="submit" value="Login">
    <label><input type="checkbox" name="auth[permanent]">Permanent login</label>
  </form>
</div>
```

The `#foot` / `#menu` sidebar still appears for the session list.

---

## Tasks

### TASK-LOGIN-01: Center the login card

Add CSS for the login screen only. The `<body>` gains class `adminer` (from `Adminer::bodyClass()`). The login page does not have a DB selected, so the `#content` margin-left should be overridden.

```css
/* Login page: no sidebar needed, center the form */
body.adminer:not(.js) #content,
body.adminer.js #content {
    /* override sidebar offset for login screens */
}
```

**Better approach:** Target the absence of logged-in state. When `page_header()` is called from `connect.inc.php`, breadcrumb is `null` (missing="auth"). Add a CSS class `no-db` or `login-page` to `<body>` via `Adminer::bodyClass()` override — but since that would require a PHP change, use the existing `<body>` class approach.

The current body classes on login are: `ltr nojs adminer` (or `ltr js adminer` after JS runs). Use an approach that does not require PHP changes:

```css
/* When #menu contains #logins (login page), center #content */
/* CSS cannot select parent — use layout approach instead */

/* Override: if #content has no content except the login form,
   the sidebar (#foot) is still positioned absolute/fixed at left.
   Push #content to center when sidebar is narrow. */
```

**Recommended approach without PHP changes:** Target `table.layout` which only appears on the login screen:

```css
/* Login form card */
table.layout {
    display: block;
    background: var(--color-surface);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    padding: var(--space-6);
    margin: var(--space-6) auto;
    max-width: 380px;
    border-spacing: 0;
}

table.layout tr {
    display: flex;
    flex-direction: column;
    margin-bottom: var(--space-4);
}

table.layout th {
    font-size: 12px;
    font-weight: 600;
    color: var(--color-muted);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 0 0 var(--space-1) 0;
    border: none;
    background: none;
}

table.layout td {
    padding: 0;
    border: none;
}

table.layout input,
table.layout select {
    width: 100%;
    padding: var(--space-2) var(--space-3);
    border: 1px solid var(--color-border);
    border-radius: var(--radius-sm);
    font-size: var(--font-size-base);
    background: var(--color-surface);
    color: var(--color-text);
    box-sizing: border-box;
}

table.layout input:focus,
table.layout select:focus {
    outline: 2px solid var(--color-primary);
    outline-offset: -1px;
}
```

---

### TASK-LOGIN-02: Style the Login button

The submit button is a plain `<input type='submit'>`. Style all submit buttons globally (see TASK-BTN-01), and additionally ensure the login submit has full-width display on the login screen:

```css
table.layout + p > input[type="submit"] {
    width: 100%;
    margin-top: var(--space-2);
}
```

---

### TASK-LOGIN-03: Style the Permanent login checkbox

```css
table.layout ~ label {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    margin-top: var(--space-3);
    font-size: 13px;
    color: var(--color-muted);
    cursor: pointer;
}
```

---

### TASK-LOGIN-04: Improve the sidebar login session list

The `#logins` `<ul>` in the sidebar shows existing sessions. Modernize list item appearance:

```css
#logins {
    padding: var(--space-3) var(--space-4);
    border-bottom: 1px solid var(--color-border);
}

#logins li {
    list-style: none;
    padding: var(--space-1) 0;
}

#logins a {
    display: block;
    padding: var(--space-2) var(--space-3);
    border-radius: var(--radius-sm);
    color: var(--color-text);
    font-size: 13px;
    transition: background 0.15s;
}

#logins a:hover {
    background: var(--color-surface-raised);
    text-decoration: none;
    color: var(--color-primary);
}
```

---

## Acceptance Criteria

- [ ] Login form renders as a centered card on wide screens
- [ ] All five `auth[*]` inputs are present and functional
- [ ] `name="logout"` submit button unchanged
- [ ] Permanent login checkbox still submits `auth[permanent]` value
- [ ] Form `method="post"` and `action=""` unchanged
- [ ] Hidden token input (`name="token"`) still present
- [ ] No PHP files modified
- [ ] Mobile layout still works (stacked)

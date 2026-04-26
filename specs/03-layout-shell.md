# Spec: Global Layout Shell

**Priority:** 3  
**Risk:** Medium — touches layout structure used by every page  
**Screen:** All screens (post-login)  
**PHP source:** `adminer/include/design.inc.php` — `page_header()`, `page_footer()`

---

## Goal

Modernize the overall page chrome: header bar, sidebar, breadcrumb, and the main content area. Improve spacing, typography, and visual hierarchy without changing any IDs, form fields, or URL parameters.

---

## Current Layout Structure

```
<body class="ltr js adminer">

  <!-- Hamburger (mobile only) -->
  <span id="menuopen" class="jsonly">...</span>

  <div id="content">
    <p id="breadcrumb">...</p>
    <h2>Page Title</h2>
    <div id="ajaxstatus" class="jsonly hidden"></div>
    <!-- flash messages: .message / .error -->
    <!-- PAGE CONTENT -->
  </div>

  <div id="foot" class="foot">
    <div id="menu">
      <h1>  ← Adminer logo + version
      <ul id="logins"> or <ul id="tables">
      <p class="links"> ← SQL, Import, Export, Create table
      ...
    </div>

    <form action="" method="post">
      <p class="logout">
        <span>username</span>
        <input type="submit" name="logout" value="Logout">
        <input type="hidden" name="token" ...>
      </p>
    </form>
  </div>

</body>
```

### Current CSS metrics

- Sidebar (`#menu`): `position: absolute; left: 0; width: 19em; top: 2em`
- Content (`#content`): `margin: 2em 0 0 21em; padding: 10px 20px 20px 0`
- Breadcrumb (`#breadcrumb`): `position: absolute; top: 0; left: 21em; height: 2em`
- Logo (`h1`): `padding: .8em .667em; border-bottom: 1px solid #999`
- Body font: Verdana 90% / 1.25

---

## Tasks

### TASK-LAYOUT-01: Sidebar visual refresh

Modernize `#menu` appearance. The sidebar position and width must not change (existing designs depend on the `19em` metric; the JS hamburger relies on `#foot`/`.foot` toggle).

```css
#menu {
    position: absolute;
    margin: 0;
    top: 0;
    left: 0;
    width: 19em;
    height: 100%;
    background: var(--color-surface);
    border-right: 1px solid var(--color-border);
    box-shadow: var(--shadow-sm);
    overflow-y: auto;
}

#menu p,
#logins,
#tables {
    padding: var(--space-3) var(--space-4);
    margin: 0;
    border-bottom: 1px solid var(--color-border);
}
```

---

### TASK-LAYOUT-02: Header / logo area

`h1` inside `#menu` renders the Adminer logo and version. It is output by `Adminer::navigation()`. CSS-only change:

```css
#menu h1 {
    font-size: 16px;
    margin: 0;
    padding: var(--space-4) var(--space-4) var(--space-3);
    border-bottom: 1px solid var(--color-border);
    font-weight: 600;
    color: var(--color-text);
    background: var(--color-surface-raised);
    display: flex;
    align-items: center;
    gap: var(--space-2);
}

#h1 {
    color: var(--color-text);
    text-decoration: none;
    font-style: normal;
    display: flex;
    align-items: center;
    gap: var(--space-2);
}

#logo {
    width: 24px;
    height: 24px;
    vertical-align: middle;
}

.version {
    color: var(--color-muted);
    font-size: 11px;
    font-weight: normal;
    margin-left: auto;
}
```

---

### TASK-LAYOUT-03: Breadcrumb bar

`#breadcrumb` is positioned `absolute; top: 0; left: 21em`. Keep positioning, modernize appearance:

```css
#breadcrumb {
    white-space: nowrap;
    position: absolute;
    top: 0;
    left: 21em;
    background: var(--color-surface-raised);
    border-bottom: 1px solid var(--color-border);
    height: 2.5em;
    line-height: 2.5em;
    padding: 0 var(--space-5);
    margin: 0;
    font-size: 13px;
    color: var(--color-muted);
}

#breadcrumb a {
    color: var(--color-muted);
    text-decoration: none;
}

#breadcrumb a:hover {
    color: var(--color-primary);
}
```

---

### TASK-LAYOUT-04: Content area spacing

```css
#content {
    margin: 2.5em 0 0 21em;
    padding: var(--space-5) var(--space-6) var(--space-6) var(--space-5);
}
```

---

### TASK-LAYOUT-05: Page title (`h2`)

```css
h2 {
    font-size: 20px;
    font-weight: 600;
    margin: 0 0 var(--space-5) 0;
    padding: 0 0 var(--space-4) 0;
    border-bottom: 1px solid var(--color-border);
    color: var(--color-text);
    background: none;
}
```

**Note:** Current `h2` has `margin: 0 0 20px -18px` and `background: var(--lit)`. The negative margin and colored background must be removed carefully — confirm no existing designs target these specific values before removing.

---

### TASK-LAYOUT-06: Flash messages (`.message`, `.error`)

```css
.message {
    padding: var(--space-3) var(--space-4);
    margin: 0 0 var(--space-4);
    background: var(--color-success-bg);
    color: var(--color-success-text);
    border: 1px solid var(--color-success-border);
    border-radius: var(--radius-sm);
    font-size: 14px;
}

.error {
    padding: var(--space-3) var(--space-4);
    margin: 0 0 var(--space-4);
    background: var(--color-error-bg);
    color: var(--color-error-text);
    border: 1px solid var(--color-error-border);
    border-radius: var(--radius-sm);
    font-size: 14px;
}
```

---

### TASK-LAYOUT-07: Logout area

The logout form is inside `#foot`, positioned `absolute; top: 0; right: 0`. Keep positioning, style:

```css
.logout {
    margin: 0;
    padding: var(--space-2) var(--space-4);
    position: absolute;
    top: 0;
    right: 0;
    background: var(--color-surface-raised);
    border-left: 1px solid var(--color-border);
    border-bottom: 1px solid var(--color-border);
    border-radius: 0 0 0 var(--radius-sm);
    display: flex;
    align-items: center;
    gap: var(--space-3);
    font-size: 13px;
}

.logout span {
    color: var(--color-muted);
}
```

---

### TASK-LAYOUT-08: Mobile layout (≤800px)

The existing `@media all and (max-width: 800px)` block handles the sidebar collapsing. Keep all existing rules. Modernize only appearance:

```css
@media all and (max-width: 800px) {
    /* Keep existing layout rules unchanged */
    /* Add only visual improvements: */
    #menu {
        box-shadow: var(--shadow-md);
    }
}
```

---

## Acceptance Criteria

- [ ] `#menu` ID retained, width remains ~19em
- [ ] `#foot` class toggle for mobile still works
- [ ] `#menuopen` hamburger still visible on mobile
- [ ] `#breadcrumb` position preserved (top, left: 21em)
- [ ] `name="logout"` submit button present
- [ ] `name="token"` hidden input present in logout form
- [ ] RTL styles (`.rtl`) not broken
- [ ] Print styles not broken
- [ ] No PHP files modified

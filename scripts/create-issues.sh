#!/usr/bin/env bash
# Creates all UI modernization GitHub issues for aswad32/adminer
# Run from repo root: bash scripts/create-issues.sh
set -euo pipefail

REPO="aswad32/adminer"

create() {
  local title="$1"
  local label="$2"
  local body="$3"
  echo "Creating: $title"
  gh issue create --repo "$REPO" --title "$title" --label "$label" --body "$body"
  sleep 0.5
}

# ─── PHASE 1: CSS Design System ───────────────────────────────────────────────

create \
  "[TASK-CSS-01] Define expanded CSS variable set on html {}" \
  "enhancement" \
'## Summary
Add a full design token system to `adminer/static/default.css` by expanding the existing `html {}` block.

## Spec
`specs/01-css-design-system.md` — TASK-CSS-01

## File
`adminer/static/default.css`

## Context
Currently only 4 CSS variables exist (`--bg`, `--fg`, `--dim`, `--lit`). All subsequent UI tasks reference the new tokens, so this must be done first.

## What to add
Expand `html {}` with variables for surfaces, text, brand/primary color, status colors, spacing scale (`--space-1` through `--space-6`), border radius, shadow, and typography.

**Constraint:** Keep `--bg`, `--fg`, `--dim`, `--lit` so existing designs and `dark.css` continue to work.

## Acceptance criteria
- [ ] New variables are present on `html {}`
- [ ] Existing `--bg`, `--fg`, `--dim`, `--lit` are not removed
- [ ] No visual regressions on existing designs in `designs/`
'

create \
  "[TASK-CSS-02] Update body {} typography" \
  "enhancement" \
'## Summary
Replace the Verdana-based `body {}` font rule with the new design token typography system.

## Spec
`specs/01-css-design-system.md` — TASK-CSS-02

## File
`adminer/static/default.css`

## Context
Current rule: `body { font: 90%/1.25 Verdana, Arial, Helvetica, sans-serif; }`
Replace with `font-family: var(--font-body)`, `font-size: var(--font-size-base)`, `line-height: var(--line-height)`.

## Acceptance criteria
- [ ] Body uses system font stack via `--font-body`
- [ ] Font size uses `--font-size-base` (14px)
- [ ] Line height uses `--line-height` (1.5)
- [ ] No hard-coded pixel or percentage font sizes on `body`
'

create \
  "[TASK-CSS-03] Update dark.css dark token overrides" \
  "enhancement" \
'## Summary
Extend `adminer/static/dark.css` to override all new CSS variables introduced in TASK-CSS-01.

## Spec
`specs/01-css-design-system.md` — TASK-CSS-03

## File
`adminer/static/dark.css`

## Dependencies
Must be done after TASK-CSS-01.

## Context
The current `dark.css` only overrides `--bg`, `--fg`, `--dim`, `--lit` plus a few hard-coded selectors. After TASK-CSS-01 adds new variables, `dark.css` needs matching dark values for each new token.

## Acceptance criteria
- [ ] Every new token from TASK-CSS-01 has a dark override
- [ ] Dark mode renders correctly with no stray light backgrounds
- [ ] Original 4 variables still overridden
'

create \
  "[TASK-CSS-04] Migrate hard-coded colors to tokens" \
  "enhancement" \
'## Summary
Replace remaining hard-coded hex colors and `#999`, `#ccc`, `#777` etc. in `default.css` with the new CSS variable tokens.

## Spec
`specs/01-css-design-system.md` — TASK-CSS-04

## File
`adminer/static/default.css`

## Dependencies
Must be done after TASK-CSS-01.

## Acceptance criteria
- [ ] No bare hex colors in `default.css` that have a corresponding token
- [ ] All border colors use `var(--color-border)`
- [ ] All muted text uses `var(--color-muted)`
'

# ─── PHASE 2: Login Screen ────────────────────────────────────────────────────

create \
  "[TASK-LOGIN-01] Center the login card" \
  "enhancement" \
'## Summary
Style the login form as a centered card using CSS only. No PHP changes required.

## Spec
`specs/02-login-screen.md` — TASK-LOGIN-01

## File
`adminer/static/default.css`

## Context
The login form is wrapped in `<table class="layout">`. Target this class to create a card-style layout centered in the viewport.

## Acceptance criteria
- [ ] Login form appears as a centered card with border, border-radius, and shadow
- [ ] Card has max-width (~380px)
- [ ] Field labels appear above inputs (flex column layout)
- [ ] No PHP changes made
- [ ] Form fields submit correctly
'

create \
  "[TASK-LOGIN-02] Style the Login submit button" \
  "enhancement" \
'## Summary
Apply primary button styles (from TASK-BTN-01) to the Login submit button specifically.

## Spec
`specs/02-login-screen.md` — TASK-LOGIN-02

## File
`adminer/static/default.css`

## Dependencies
TASK-BTN-01 (primary button styles)

## Acceptance criteria
- [ ] Login button uses primary color
- [ ] Full-width within the login card
- [ ] Focus state visible
'

create \
  "[TASK-LOGIN-03] Style the Permanent login checkbox" \
  "enhancement" \
'## Summary
Improve the layout and visual treatment of the "Permanent login" checkbox below the Login button.

## Spec
`specs/02-login-screen.md` — TASK-LOGIN-03

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Checkbox and label are horizontally aligned
- [ ] Adequate spacing from the Login button
'

create \
  "[TASK-LOGIN-04] Improve sidebar login session list" \
  "enhancement" \
'## Summary
Style `#logins` (the saved sessions list shown in the sidebar on the login page).

## Spec
`specs/02-login-screen.md` — TASK-LOGIN-04

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Session list items have clear hover states
- [ ] Consistent spacing with rest of sidebar
- [ ] No HTML changes
'

# ─── PHASE 2: Layout Shell ────────────────────────────────────────────────────

create \
  "[TASK-LAYOUT-01] Sidebar visual refresh" \
  "enhancement" \
'## Summary
Modernize the `#menu` sidebar appearance: background, border, shadow.

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-01

## File
`adminer/static/default.css`

## Context
`#menu` is `position: absolute; left: 0; width: 19em`. The 19em width must not change. The `#foot`/`.foot` toggle relied on by the JS hamburger must be preserved.

## Acceptance criteria
- [ ] Sidebar has surface background, right border, subtle shadow
- [ ] 19em width preserved
- [ ] Mobile hamburger still works
'

create \
  "[TASK-LAYOUT-02] Header / logo area" \
  "enhancement" \
'## Summary
Style `h1` inside `#menu` (Adminer logo + version) and `#h1` / `#logo`.

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-02

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Logo area has consistent padding and bottom border
- [ ] Logo image properly sized and aligned
- [ ] `#h1` link has no underline, uses text color
'

create \
  "[TASK-LAYOUT-03] Breadcrumb bar" \
  "enhancement" \
'## Summary
Style the `#breadcrumb` bar (positioned absolutely at the top of the content area).

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-03

## File
`adminer/static/default.css`

## Context
Current: `position: absolute; top: 0; left: 21em; height: 2em`. The position is relied on by JavaScript.

## Acceptance criteria
- [ ] Breadcrumb has bottom border separator
- [ ] Text uses muted color token
- [ ] Breadcrumb separators (` » `) visually clear
'

create \
  "[TASK-LAYOUT-04] Content area spacing" \
  "enhancement" \
'## Summary
Improve padding and spacing inside `#content`.

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-04

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Content has consistent padding using spacing tokens
- [ ] No overlap with sidebar
'

create \
  "[TASK-LAYOUT-05] Page title (h2)" \
  "enhancement" \
'## Summary
Style `h2` elements inside `#content` (page title output by `page_header()`).

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-05

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] h2 uses appropriate font size and weight
- [ ] Bottom margin/border for visual separation
'

create \
  "[TASK-LAYOUT-06] Flash messages (.message, .error)" \
  "enhancement" \
'## Summary
Style `.message` and `.error` notification banners output by `page_messages()`.

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-06

## File
`adminer/static/default.css`

## Context
PHP: `page_messages()` in `design.inc.php`. Both classes use `<div class="message">` and `<div class="error">`.

## Acceptance criteria
- [ ] `.message` uses success color tokens (green)
- [ ] `.error` uses error color tokens (red)
- [ ] Border-radius applied
- [ ] Clear spacing from surrounding content
'

create \
  "[TASK-LAYOUT-07] Logout area" \
  "enhancement" \
'## Summary
Style the logout form at the bottom of the sidebar (`.logout` inside `#foot`).

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-07

## File
`adminer/static/default.css`

## Context
HTML: `<p class="logout"><span>username</span><input type="submit" name="logout" value="Logout">`. The `name="logout"` attribute must not change.

## Acceptance criteria
- [ ] Username and logout button horizontally arranged
- [ ] Logout button styled distinctly from primary actions
- [ ] Padding consistent with sidebar
'

create \
  "[TASK-LAYOUT-08] Mobile layout (≤800px)" \
  "enhancement" \
'## Summary
Improve the mobile layout breakpoint at 800px — sidebar overlay behavior, content full-width.

## Spec
`specs/03-layout-shell.md` — TASK-LAYOUT-08

## File
`adminer/static/default.css`

## Context
The existing `@media all and (max-width: 800px)` breakpoint must be extended, not replaced.

## Acceptance criteria
- [ ] Content spans full width on mobile
- [ ] Sidebar overlays content when open
- [ ] Hamburger button (#menuopen) is tappable
'

# ─── PHASE 3: Navigation ──────────────────────────────────────────────────────

create \
  "[TASK-NAV-01] Table list items" \
  "enhancement" \
'## Summary
Style `#tables` list items: hover states, active state, ellipsis overflow.

## Spec
`specs/04-sidebar-navigation.md` — TASK-NAV-01

## File
`adminer/static/default.css`

## Context
`#tables` has JS mouseover handlers (`menuOver`/`menuOut`). The `<a>` and `<span>` elements need `background` set for the JS column hover overlay to work. Do not remove `background` from `#tables a, #tables span`.

## Acceptance criteria
- [ ] List items have hover background
- [ ] Active item (`.active`) highlighted with primary color
- [ ] Long table names truncated with ellipsis
- [ ] JS hover column menu still works
'

create \
  "[TASK-NAV-02] Sidebar action links" \
  "enhancement" \
'## Summary
Style `<p class="links">` inside `#menu` — SQL command, Import, Export, Create table links.

## Spec
`specs/04-sidebar-navigation.md` — TASK-NAV-02

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Links styled as small pill or subtle button
- [ ] Consistent gap between links
- [ ] Hover state uses primary color
'

create \
  "[TASK-NAV-03] Database list (#dbs)" \
  "enhancement" \
'## Summary
Style `#dbs` — the AJAX-populated database switcher in the sidebar.

## Spec
`specs/04-sidebar-navigation.md` — TASK-NAV-03

## File
`adminer/static/default.css`

## Context
`#dbs` is populated via `fillDbs()` in `functions.js`. Structure and IDs must not change.

## Acceptance criteria
- [ ] Database items have hover state
- [ ] Active database highlighted
- [ ] Consistent with table list styling
'

create \
  "[TASK-NAV-04] Language switcher (#lang)" \
  "enhancement" \
'## Summary
Style the `#lang` language switcher link group in the sidebar.

## Spec
`specs/04-sidebar-navigation.md` — TASK-NAV-04

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Language options use small text
- [ ] Adequate spacing
'

create \
  "[TASK-NAV-05] Mobile hamburger button" \
  "enhancement" \
'## Summary
Style `#menuopen` hamburger button for mobile — improve tap target size and appearance.

## Spec
`specs/04-sidebar-navigation.md` — TASK-NAV-05

## File
`adminer/static/default.css`

## Context
`#menuopen` has class `jsonly` — it is only visible when JS is enabled. It toggles the `.foot` class on `<body>`.

## Acceptance criteria
- [ ] Tap target at least 44×44px
- [ ] Visually clear hamburger icon
- [ ] Correct z-index to appear above content
'

# ─── PHASE 4: Controls ────────────────────────────────────────────────────────

create \
  "[TASK-BTN-01] Primary submit button" \
  "enhancement" \
'## Summary
Style all `<input type="submit">` and `<button type="submit">` as modern primary buttons.

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-01

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Blue primary color from `--color-primary`
- [ ] Hover darkens via `--color-primary-hover`
- [ ] Focus ring visible
- [ ] `.default` class still shows highlight (not box-shadow, use outline)
- [ ] Correct cursor
'

create \
  "[TASK-BTN-02] Danger / destructive button variants" \
  "enhancement" \
'## Summary
Visually distinguish destructive submit buttons (Drop, Truncate, Delete).

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-02

## File
`adminer/static/default.css` (CSS) — optionally `adminer/edit.inc.php` (PHP class addition, decision required)

## Context
PHP renders delete as `<input type="submit" name="drop" value="Drop">`. CSS attribute selectors like `[name="drop"]`, `[name="delete"]`, `[name="truncate"]` can be used without PHP changes.

**Decision required:** Accept CSS-only attribute selectors, or add `class="danger"` to the PHP template.

## Acceptance criteria
- [ ] Drop/Delete/Truncate buttons visually distinct (red)
- [ ] No logic changes
- [ ] Decision documented in PR
'

create \
  "[TASK-BTN-03] Secondary / neutral buttons" \
  "enhancement" \
'## Summary
Style secondary/neutral action buttons with a ghost or outlined appearance.

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-03

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Neutral buttons have border, no filled background
- [ ] Consistent size with primary buttons
'

create \
  "[TASK-BTN-04] Icon buttons (.icon)" \
  "enhancement" \
'## Summary
Improve `.icon` button appearance — better hit target, hover state.

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-04

## File
`adminer/static/default.css`

## Context
Icons are 18×18px `<input>` or `<button>` elements with `background-image` (base64 GIF). The `.icon span` text is `display: none` for screen readers.

## Acceptance criteria
- [ ] Hit area at least 28×28px
- [ ] Hover state uses a subtle highlight (not `background-color: red`)
- [ ] Hidden span text still accessible
'

create \
  "[TASK-BTN-05] Form action bar (.footer)" \
  "enhancement" \
'## Summary
Style the `.footer` form action bar (bottom of edit/create forms) with proper spacing and alignment.

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-05

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Action bar has top border separator
- [ ] Buttons spaced correctly with gap
- [ ] Sticky or fixed positioning not introduced (preserve scroll behavior)
'

create \
  "[TASK-BTN-06] Text inputs and selects (global)" \
  "enhancement" \
'## Summary
Apply consistent modern styling to all `<input type="text">`, `<input type="password">`, and `<select>` elements globally.

## Spec
`specs/05-buttons-controls.md` — TASK-BTN-06

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Inputs have border, border-radius, padding using tokens
- [ ] Focus state uses `--color-primary` ring
- [ ] No change to `name=` attributes or form behavior
'

# ─── PHASE 5: Data Tables ─────────────────────────────────────────────────────

create \
  "[TASK-TABLE-01] Base table reset and spacing" \
  "enhancement" \
'## Summary
Modernize base `table`, `td`, `th` styles with `border-collapse: collapse` and token-based spacing.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-01

## File
`adminer/static/default.css`

## Context
Current model uses `border-width: 1px 0 0 1px` on table + `0 1px 1px 0` on cells. Switching to `border-collapse: collapse` simplifies this. Test carefully.

## Acceptance criteria
- [ ] `border-collapse: collapse` used
- [ ] Cell padding uses `--space-2` / `--space-3`
- [ ] Font size uses `--font-size-base`
- [ ] No visual double-borders
'

create \
  "[TASK-TABLE-02] Column headers (th, thead)" \
  "enhancement" \
'## Summary
Style `th` and `thead` cells for clearer visual hierarchy.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-02

## File
`adminer/static/default.css`

## Context
`thead` must remain `position: sticky; top: 0` — this is important for the browse screen.

## Acceptance criteria
- [ ] `thead` background uses `--color-surface-raised`
- [ ] `th` font-weight: 600, smaller text size
- [ ] Sticky header still works on scroll
'

create \
  "[TASK-TABLE-03] Row hover and selection states" \
  "enhancement" \
'## Summary
Modernize `tbody tr:hover` and `.checked` selected row states.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-03

## File
`adminer/static/default.css`

## Context
`.checked` class is toggled by JS (`tableClick` in `functions.js`). Do not rename this class.

## Acceptance criteria
- [ ] Hover state uses `--color-surface-raised`
- [ ] `.checked` state uses `--lit` or a light primary tint
- [ ] Alternating rows (`.odds`) preserved
'

create \
  "[TASK-TABLE-04] Scrollable table wrapper (.scrollable)" \
  "enhancement" \
'## Summary
Improve `.scrollable` wrapper div used for wide tables — better scroll indicator, subtle border.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-04

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] `.scrollable` has border and border-radius
- [ ] Scroll shadow or fade indicator on overflow
'

create \
  "[TASK-TABLE-05] Null / special value display (.null, .time)" \
  "enhancement" \
'## Summary
Style null values (`<i>NULL</i>`, via `selectVal()`) and timestamp cells (`.time`).

## Spec
`specs/06-data-tables.md` — TASK-TABLE-05, TASK-TABLE-08

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] NULL values visually distinct (italic, muted color)
- [ ] `.time` cells use monospace font
'

create \
  "[TASK-TABLE-06] Pagination" \
  "enhancement" \
'## Summary
Style pagination links output by `pagination()` in `html.inc.php`.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-06

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] Pagination links look like pill buttons
- [ ] Current page highlighted
- [ ] Adequate spacing between page links
'

create \
  "[TASK-TABLE-07] Nested tables (td table)" \
  "enhancement" \
'## Summary
Reset nested `<table>` elements inside `<td>` so they do not inherit outer table border styles.

## Spec
`specs/06-data-tables.md` — TASK-TABLE-07

## File
`adminer/static/default.css`

## Acceptance criteria
- [ ] `td table` has reset margin and distinct styling
- [ ] No doubled borders in nested tables
'

# ─── PHASE 6: Per-Screen Polish ───────────────────────────────────────────────

create \
  "[TASK-EDIT-01 through EDIT-05] Insert/edit row form styling" \
  "enhancement" \
'## Summary
Modernize the insert/edit row form: edit table layout, function column, input cells, enum/set fields, and action buttons.

## Spec
`specs/07-edit-form.md` — TASK-EDIT-01 through TASK-EDIT-05

## File
`adminer/static/default.css`

## Context
The edit form uses `<table>` with a `td.function` column (function selector dropdown) and a `td` input column. The `input()` function in `html.inc.php` renders these cells. Do not change any `name=` attributes.

## Tasks in this issue
- **EDIT-01** Edit table layout — `table.layout td.function` alignment
- **EDIT-02** Function column styling — `td.function select` width/style
- **EDIT-03** Input cells — inputs/textareas inside edit table
- **EDIT-04** Enum/set radio+checkbox — grid layout for options
- **EDIT-05** Form action buttons — spacing in the edit footer

## Acceptance criteria
- [ ] Function selector and input are visually aligned in a row
- [ ] Textareas have min-height
- [ ] Enum/set options in a wrapping flex grid
- [ ] Action buttons spaced consistently
- [ ] No form field name changes
'

create \
  "[TASK-SQL-01 through SQL-04] SQL command screen styling" \
  "enhancement" \
'## Summary
Modernize the SQL command screen: textarea, form footer, result display, and query history.

## Spec
`specs/08-sql-command-screen.md` — TASK-SQL-01 through TASK-SQL-04

## File
`adminer/static/default.css`

## Context
The SQL textarea has `id="sqlquery"`. Syntax highlighting (jush) applies classes to its content. The textarea must not get `overflow: hidden` or `resize: none` — users need to resize it.

## Tasks in this issue
- **SQL-01** SQL textarea — min-height, font-family mono, border-radius
- **SQL-02** SQL form footer — button spacing
- **SQL-03** Query result display — margin, message styling
- **SQL-04** Query history panel — `#history` panel styling

## Acceptance criteria
- [ ] SQL textarea uses monospace font via `--font-mono`
- [ ] Textarea resizable vertically
- [ ] History panel clearly separated from main form
- [ ] No change to `id="sqlquery"` or form submission
'

create \
  "[TASK-SELECT-01 through SELECT-06] Select filter/sort bar styling" \
  "enhancement" \
'## Summary
Modernize the filter/sort/limit/action bar above the browse table.

## Spec
`specs/09-select-filter-bar.md` — TASK-SELECT-01 through TASK-SELECT-06

## File
`adminer/static/default.css`

## Context
Filter/sort/limit/length/action controls are rendered as `<fieldset>` elements by `selectColumnsPrint()`, `selectSearchPrint()`, `selectOrderPrint()`, `selectLimitPrint()`, `selectActionPrint()`. Each fieldset uses `print_fieldset()` from `html.inc.php` which adds a JS collapse toggle. The `.hidden` class must not be renamed.

## Tasks in this issue
- **SELECT-01** Fieldset container styling
- **SELECT-02** Fieldset inner div (collapsible)
- **SELECT-03** .size inputs (numeric width inputs)
- **SELECT-04** No-index warning styling
- **SELECT-05** Action bar below data table
- **SELECT-06** Links bar (`.links` above table)

## Acceptance criteria
- [ ] Fieldsets have card-like appearance
- [ ] Collapse/expand animation preserved
- [ ] `.hidden` class still hides/shows content
- [ ] Action bar has consistent button spacing
'

create \
  "[TASK-STRUCT-01 through STRUCT-04] Table structure and schema styling" \
  "enhancement" \
'## Summary
Modernize table structure view, alter table column editor, index table, and ER diagram schema cards.

## Spec
`specs/10-table-structure-schema.md` — TASK-STRUCT-01 through TASK-STRUCT-04

## File
`adminer/static/default.css`

## Tasks in this issue
- **STRUCT-01** Structure table column widths
- **STRUCT-02** Column editor table (alter table form)
- **STRUCT-03** Index table
- **STRUCT-04** Schema table cards (ER diagram — `#schema` div)

## Acceptance criteria
- [ ] Column names clearly readable
- [ ] Alter table form rows clearly separated
- [ ] Schema boxes have card styling with border-radius
'

create \
  "[TASK-DUMP-01, DUMP-02, DUMP-04] Export/import screen styling" \
  "enhancement" \
'## Summary
Modernize the export (dump) and import screens: fieldset groups, radio/checkbox lists, and file input.

## Spec
`specs/11-export-import.md` — TASK-DUMP-01, TASK-DUMP-02, TASK-DUMP-04

## File
`adminer/static/default.css`

## Tasks in this issue
- **DUMP-01** Export fieldset groups — card appearance
- **DUMP-02** Radio/checkbox option lists — grid layout
- **DUMP-04** Import file input — styled file input area

## Acceptance criteria
- [ ] Export options grouped clearly with visual separation
- [ ] Radio/checkbox lists in a two-column grid
- [ ] File input has clear affordance
'

# ─── PHASE 7: Responsive + Dark Mode ─────────────────────────────────────────

create \
  "[TASK-RESP-01 through RESP-05] Responsive layout improvements" \
  "enhancement" \
'## Summary
Improve the mobile/responsive layout: sidebar overlay, touch targets, breadcrumb, tables, and logout area.

## Spec
`specs/12-responsive-layout.md` — TASK-RESP-01 through TASK-RESP-05

## File
`adminer/static/default.css`

## Tasks in this issue
- **RESP-01** Improved mobile sidebar overlay behavior
- **RESP-02** Touch targets (minimum 44×44px for all interactive elements)
- **RESP-03** Responsive breadcrumb (hidden or stacked on small screens)
- **RESP-04** Responsive tables (horizontal scroll wrapper on small screens)
- **RESP-05** Responsive logout area

## Acceptance criteria
- [ ] All interactive elements ≥44px tall on mobile
- [ ] Sidebar slides in/out smoothly on mobile
- [ ] Tables scroll horizontally on small screens without breaking layout
- [ ] Existing `@media (max-width: 800px)` block extended, not duplicated
'

create \
  "[TASK-DARK-01 through DARK-05] Dark mode token overrides and polish" \
  "enhancement" \
'## Summary
Complete dark mode support: new token overrides, form control colors, icon inversion check, schema diagram, and dark switcher plugin compatibility.

## Spec
`specs/13-dark-mode.md` — TASK-DARK-01 through TASK-DARK-05

## File
`adminer/static/dark.css`

## Dependencies
Must be done after TASK-CSS-01 (new tokens) and all other visual tasks.

## Tasks in this issue
- **DARK-01** New token dark overrides (all tokens from TASK-CSS-01)
- **DARK-02** Dark mode form controls (inputs, selects, textareas)
- **DARK-03** Dark mode icon inversion — verify base64 GIF icons are visible
- **DARK-04** Dark mode schema diagram card backgrounds
- **DARK-05** Body class dark toggle compatibility with `dark-switcher.php` plugin

## Acceptance criteria
- [ ] All surfaces use dark tokens
- [ ] Form controls have dark background and light text
- [ ] Icons visible in dark mode (invert filter or replacement)
- [ ] `dark-switcher.php` plugin still works
- [ ] No stray `#fff` or `#000` hard-coded values remain
'

echo ""
echo "✅ All issues created successfully."

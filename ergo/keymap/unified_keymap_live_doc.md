# Unified Keymap – Live Document

This living document consolidates your full environment keybindings (Kitty → Zellij → Yazi → Helix) using the **unified vi‑style motion grammar** defined in your *Motions* chat. All navigation, pane movement, selection, and traversal follow consistent **h/j/k/l**, **g‑motions**, and **Ctrl‑motions** across the whole stack.

---

# 1. Vi‑Style Motion Grammar (Global)
The following motion grammar applies across all tools:

## **Core Axes (Directional)**
- **h** → left / previous / back
- **j** → down / next / forward
- **k** → up / previous / back
- **l** → right / enter / open

## **Extended Motions**
- **gg** → top / first / start
- **G** → bottom / last / end
- **Ctrl+u** → page up / half‑page up
- **Ctrl+d** → page down / half‑page down

## **Traversal Semantics**
- **Enter/Drill‑down:** `l`
- **Back/Ascend:** `h`
- **Advance:** `j`
- **Retreat:** `k`

---

# 2. Kitty – Terminal Layer
Kitty uses **Ctrl+Shift** keybindings and does not conflict with vi‑motion grammar.

## Tabs & Windows
- New tab: `Ctrl+Shift+t`
- Next / Prev tab: `Ctrl+Shift+Right / Left`
- Vertical split: `Ctrl+Shift+v`
- Horizontal split: `Ctrl+Shift+s`
- Close: `Ctrl+Shift+q`

## Search & Scroll
- Search scrollback: `Ctrl+Shift+f`
- Scroll: `Shift+PageUp / PageDown`

---

# 3. Zellij – Multiplexer Layer
Zellij is aligned to the vi‑motion grammar through **directional focus movement** and **stack cycling**.

## Pane Focus (vi‑grammar)
- Move focus **Up**: `Alt+u` → *(k‑semantic)*
- Move focus **Down**: `Alt+i` → *(j‑semantic)*

(These Alt‑motions are used because Zellij consumes Ctrl‑hjkl, and the K380 has constraints.)

## Zellij Prefix
- Prefix: `Ctrl+g`

## Pane Operations
- Horizontal split: `Ctrl+g` → `-`
- Vertical split: `Ctrl+g` → `|`
- Toggle floating: `Ctrl+g` → `f`
- Close pane: `Ctrl+g` → `x`

## Tabs
- New tab: `Ctrl+g` → `t`
- Next / Prev tab: `Ctrl+g` → `] / [`

## Layouts & Session
- Swap layout: `Ctrl+g` → `z`
- Detach: `Ctrl+g` → `d`

---

# 4. Yazi – File Manager Layer
Yazi follows vi‑motion semantics strictly.

## Navigation
- Up/Down/Left/Right: `k/j/h/l`
- Smart enter/open: `l`
- Back: `h`
- Redraw: `R`

## Preview Control
- Toggle preview: `Ctrl+p`
- Preview narrower/wider: `Ctrl+[ / Ctrl+]`
- Minimal preview toggle: `T`

## File Operations
- Smart paste: `p`
- Copy paths: `y`
- Open in Helix: `e`
- Open Helix floating pane: `Ctrl+e`
- Open shell: `!`

## Dev & Git Tools
- Git change view: `g c`
- LazyGit floating: `Ctrl+g`

## Search
- Internal search: `/`
- External ripgrep: `?`

---

# 5. Helix – Editor Layer
Helix is already deeply aligned to vi‑style navigation and editing.

## Core Movement (vi‑grammar)
- Move: `h j k l`
- Page: `Ctrl+u / Ctrl+d`
- Jump: `gg / G`

## Splits
- Vertical split: `:vsplit`
- Horizontal split: `:hsplit`
- Move between splits: `Ctrl+w + h/j/k/l`

## Search
- Search: `/`
- Next / Prev result: `n / N`

## Yazi Picker Integration (Floating Zellij Pane)
Prefix: `Ctrl+y`
- Open in current window: `y`
- Vertical split: `v`
- Horizontal split: `h`

---

# 6. Cross‑Tool Alignment Summary

## Motion Grammar
- All tools use **h/j/k/l** for motion.
- **gg/G** semantics are aligned where applicable.
- **Ctrl+u / Ctrl+d** behave as paging in Helix, Yazi, and scroll contexts.

## Leader / Prefix Separation
- **Zellij:** `Ctrl+g`
- **Helix → Yazi Picker:** `Ctrl+y`
- **Yazi → Helix:** `e` / `Ctrl+e`

No collisions.

## Modifier Discipline
- **Alt‑layer:** reserved for Zellij navigation.
- **Ctrl‑layer:** reserved for cross‑tool actions (Yazi picker, preview toggles, Zellij prefix, floating editors).
- **Base vi‑layer:** universal h/j/k/l.

---

# 7. Workflow Diagrams (Textual)

## Helix → Yazi → Helix Round‑Trip
1. `Ctrl+y` → Launch Yazi picker
2. Navigate using `h/j/k/l`
3. Choose target:
   - `y` → open here
   - `v` → vertical split
   - `h` → horizontal split
4. Return to Helix (auto‑close float)

## Yazi → LazyGit → Yazi / Helix
1. `Ctrl+g` → LazyGit (float)
2. Navigate with Alt‑u / Alt‑i
3. Close or return to Yazi
4. From Yazi: `e` or `Ctrl+e` to jump into Helix

## Zellij Workspace Flow
- Panes: Alt‑u / Alt‑i
- Tabs: `Ctrl+g` → `[` or `]`
- Float any tool: `Ctrl+g` → `f`

---

# 8. TODO / Future Additions
- Add kitty‑level vi‑navigation mappings (optional)
- Define a unified leader key for future AI‑augmented commands
- Add keyboard‑layout diagram for Logitech K380

---

# End of Live Document
This document is maintained incrementally and can be updated as your environment evolves.


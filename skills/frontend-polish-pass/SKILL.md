---
name: frontend-polish-pass
description: Improve existing frontend UI quality with implementation and visual verification. Use when Codex is asked to make an interface feel polished, responsive, accessible, less cluttered, better aligned with a design system, or to verify UI changes with screenshots and browser checks.
---

# Frontend Polish Pass

Treat polish as product work: layout, hierarchy, states, motion, accessibility, and responsiveness all need to serve the user's task.

## Workflow

1. Learn the UI system:
   - Inspect existing components, spacing, colors, typography, icons, and state patterns.
   - Identify the app type: dashboard, editor, marketing site, game, docs, commerce, or internal tool.
   - Use existing component libraries and icon sets.
2. Improve the real workflow:
   - Prioritize the screen or path the user named.
   - Make dense tools scannable and efficient.
   - Make landing or editorial pages visually specific to the subject.
   - Build complete states: loading, empty, error, disabled, hover/focus, mobile.
3. Stabilize layout:
   - Use responsive constraints, grid/flex rules, stable aspect ratios, and min/max widths.
   - Ensure text does not overflow buttons, cards, tabs, sidebars, or toolbars.
   - Avoid layout shift from dynamic content.
4. Verify visually:
   - Run the app if needed.
   - Use browser screenshots at desktop and mobile widths when tools are available.
   - Check important interactions, not just first paint.
   - Inspect console errors if available.

## Design Heuristics

- Match the domain: operational tools should be calm and dense; creative apps can be expressive.
- Prefer familiar controls: icon buttons for common tools, tabs for views, toggles for binary settings, sliders or inputs for numbers, menus for option sets.
- Keep cards for repeated items, modals, and framed tools; avoid nesting cards.
- Use real or generated bitmap imagery for websites that need visual assets.
- Keep headings proportional to their container.
- Avoid one-note color palettes and decorative background blobs.
- Use accessible contrast, focus states, labels, and keyboard-reachable controls.

## Visual QA Checklist

- Desktop viewport works without awkward whitespace or overlap.
- Mobile viewport works without horizontal scroll unless intentionally designed.
- Long labels and realistic data fit.
- Empty/error/loading states are coherent.
- Buttons and inputs have hover, focus, disabled, and active feedback.
- Icons align optically with text.
- Images and canvases are nonblank and correctly framed.
- No console errors from the changed path.

## Output

When done, summarize:

- What changed visually and behaviorally.
- Which viewports or interactions were checked.
- Any remaining design risks or assets that would improve the result.

If screenshots cannot be taken, say which manual/browser checks were unavailable and still run code-level checks where useful.

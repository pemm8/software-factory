# Todo List

A basic Todo List in one static file, `index.html`, using HTML, CSS and Alpine.js (loaded from a pinned CDN URL).

## Run

Open `index.html` in a browser (network access is needed on first load for the Alpine CDN), or serve it:

```
python3 -m http.server 5100
```

then open <http://localhost:5100/index.html>.

## Features

- Add, edit (button or double-click), delete and complete tasks
- All / Active / Completed filter
- Remaining count ("1 task left")
- Responsive layout
- Tasks persist in the browser

## Data

Tasks are stored in the browser's `localStorage` under `todo-app.tasks`, per browser and per origin, so `file://` and `http://localhost` lists are separate.

## Manual test checklist

- [ ] Page loads with empty storage and no console errors.
- [ ] "Buy milk" + Enter adds a task, clears the input, shows "1 task left". Empty or whitespace-only Add does nothing.
- [ ] Ticking a task marks it completed and lowers the count; unticking restores it.
- [ ] Edit changes the text on Enter/Save; empty save keeps the original; Escape/Cancel discards.
- [ ] Delete removes a task immediately and updates the count; the page never reloads.
- [ ] Filters show the right tasks, highlight the selected one, keep the count, and show "No tasks" when empty.
- [ ] Reload keeps tasks and completed state; `localStorage.getItem('todo-app.tasks')` is a JSON array.
- [ ] Storage set to `not json` or `{"a":1}` loads an empty list without errors.
- [ ] A task named `<img src=x onerror=alert(1)>` shows as literal text.
- [ ] At 320px and 375px there is no horizontal scroll and a 200-character word wraps; at 1280px the column is centred.

## Factory

The `factory/` directory is the software factory that built this; see `AGENTS.md`.

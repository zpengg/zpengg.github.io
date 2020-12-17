{
  "key": "f8",
  "command": "editor.action.marker.nextInFiles",
  "when": "editorFocus"
}

{
  "key": "alt+cmd+f",
  "command": "editor.action.startFindReplaceAction",
  "when": "editorFocus || editorIsOpen"
}

{
  "key": "cmd+p",
  "command": "workbench.action.quickOpen"
}

{
  "key": "alt+cmd+.",
  "command": "editor.action.autoFix",
  "when": "editorTextFocus && !editorReadonly && supportedCodeAction =~ /(\\s|^)quickfix\\b/"
}
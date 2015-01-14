project = require 'zooniverse-readymade/current-project'
{markingSurface} = project.classifyPages[0].subjectViewer

DISMISS_BUTTON_SELECTOR = '.marking-surface-tool-controls[data-selected="true"] button[name="readymade-dismiss-details"]'

markingSurface.addEvent 'marking-surface:tool:select', ->
  dismissButton = markingSurface.el.querySelector DISMISS_BUTTON_SELECTOR
  dismissButton?.innerHTML = 'Close'

project = require 'zooniverse-readymade/current-project'
window.project = project

classifyPage = project.classifyPages[0]
{ decisionTree, subjectViewer } = classifyPage

setupBeforeAndAfterToggle = ->
  return if classifyPage.hasSetupBeforeAndAfter
  $(decisionTree.el).find('[name="decision-tree-go-back"]').after $ '''
    <button type="button" name="decision-tree-before-and-after" data-showing="after">Show Before</button>
  '''
  
  beforeAndAfter = $(decisionTree.el).find('[name="decision-tree-before-and-after"]')
  
  beforeAndAfter.on 'click', (ev) ->
    ev.preventDefault()
    current = beforeAndAfter.attr 'data-showing'
    
    if current is 'after'
      beforeAndAfter.text 'Show After'
      beforeAndAfter.attr 'data-showing', 'before'
      subjectViewer.markingSurface.disable()
      subjectViewer.goTo 1
    else
      beforeAndAfter.text 'Show Before'
      beforeAndAfter.attr 'data-showing', 'after'
      subjectViewer.markingSurface.enable()
      subjectViewer.goTo 0
  
  classifyPage.hasSetupBeforeAndAfter = true

classifyPage.on classifyPage.LOAD_SUBJECT, (e, subject) ->
  setupBeforeAndAfterToggle()
  subjectViewer.markingSurface.enable()
  subjectViewer.addFrame subject.location.before
  subjectViewer.goTo 0

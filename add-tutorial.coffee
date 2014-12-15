project = require 'zooniverse-readymade/current-project'
{Tutorial} = require 'zootorial'

classifyPage = project.classifyPages[0]

classifyPage.tutorial = new Tutorial
  parent: classifyPage.el.get 0
  attachment: [0.5, 0.5, classifyPage.el.get(0), 0.5, 0.5]
  steps: require './tutorial-steps'

classifyPage.startTutorial = ->
  @tutorial.start()
  @trigger @START_TUTORIAL, this, @tutorial

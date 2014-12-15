project = require 'zooniverse-readymade/current-project'
{Tutorial} = require 'zootorial'
User = require 'zooniverse/models/user'

classifyPage = project.classifyPages[0]

classifyPage.tutorial = new Tutorial
  parent: classifyPage.el.get 0
  attachment: [0.5, 0.5, classifyPage.el.get(0), 0.5, 0.5]
  steps: require './tutorial-steps'

classifyPage.tutorial.el.addEventListener classifyPage.tutorial.endEvent, ->
  User.current?.setPreference 'tutorial_done', true

classifyPage.startTutorial = ->
  @tutorial.start()
  @trigger @START_TUTORIAL, this, @tutorial

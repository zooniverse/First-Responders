project = require 'zooniverse-readymade/current-project'
{Subject} = project.classifyPages[0]

module.exports = ->
  Subject.instances.shift() if Subject.instances?[0]?.tutorial

  subject = new Subject
    id: 'TODO_TUTORIAL_SUBJECT_ID'
    coords: [0, 0]
    location:
      before: './tutorial-images/before.jpg'
      standard: './tutorial-images/standard.jpg'
    metadata: {}
    project_id: 'TODO_PROJECT_ID'
    tutorial: true
    workflow_ids: ['TODO_WORKFLOW_ID']
    zooniverse_id: 'TODO_ZOONIVERSE_ID'

  subject.select()

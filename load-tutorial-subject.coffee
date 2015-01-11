project = require 'zooniverse-readymade/current-project'
{Subject} = project.classifyPages[0]

module.exports = ->
  Subject.instances.shift() if Subject.instances?[0]?.tutorial

  subject = new Subject
    id: '54b307877b9f996e29000001'
    coords: [0, 0]
    location:
      before: './tutorial-images/before.jpg'
      standard: './tutorial-images/standard.jpg'
    metadata: {}
    project_id: '5432c7433ae7404eca000001'
    tutorial: true
    workflow_ids: ['5432c7433ae7404eca000001']
    zooniverse_id: 'AFR00002ak'

  subject.select()

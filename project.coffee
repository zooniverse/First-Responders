# MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

module.exports =
  id: 'first_responder'
  background: 'http://upload.wikimedia.org/wikipedia/commons/7/75/Sign_first_aid.svg'

  producer: 'The name of your group'
  title: 'First Responders'
  summary: 'A catchy phrase summing up the project'
  description: 'This is a brief but slightly more detailed project description.'

  tasks:
    features:
      type: 'drawing',
      question: 'Select and mark any of the following features.',
      choices: [{
        type: 'point'
        value: 'crowd',
        label: 'Crowd of People'
        color: 'orange'
      }, {
        type: 'point'
        value: 'blocked_road',
        label: 'Blocked Road'
        color: 'gray'
      }, {
        type: 'point'
        value: 'tarp',
        label: 'Tarp/Shelter'
        color: 'teal'
      }, {
        type: 'point'
        value: 'flooding',
        label: 'Flooding'
        color: 'lime'
      }, {
        type: 'point'
        value: 'structural_damage',
        label: 'Structural damage'
        color: 'red'
        details: [{
          type: 'radio'
          question: 'Approximate damage assessment:'
          key: 'damage_assessment'
          choices: [{
            value: 0 / 2
            label: '<strong>Mild to Moderate:</strong> visible, but structure intact'
          }, {
            value: 1 / 2
            label: '<strong>Severe:</strong> major damage, but structure still recognizable'
          }, {
            value: 2 / 2
            label: '<strong>Total:</strong> collapsed walls/roof or structure unrecognizable'
          }]
        }]
      }]

  firstTask: 'features'

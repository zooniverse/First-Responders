# MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

module.exports =
  id: 'TODO'
  background: 'http://upload.wikimedia.org/wikipedia/commons/7/75/Sign_first_aid.svg'

  producer: 'The name of your group'
  title: 'First Responders'
  summary: 'A catchy phrase summing up the project'
  description: 'This is a brief but slightly more detailed project description.'

  tasks:
    features:
      type: 'drawing',
      question: 'Select and mark any of the follow features.',
      choices: [{
        type: 'point'
        value: 'people',
        label: 'People'
        color: 'orange'
      }, {
        type: 'point'
        value: 'road_blockage',
        label: 'Road blockage'
        color: 'gray'
      }, {
        type: 'point'
        value: 'tarp',
        label: 'Tarp'
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
            value: 0 / 3
            label: '<strong>Mild:</strong> probably only exterior damage'
          }, {
            value: 1 / 3
            label: '<strong>Moderate:</strong> possible risk of collapse'
          }, {
            value: 2 / 3
            label: '<strong>Dangerous:</strong> collapsed walls or roof'
          }, {
            value: 3 / 3
            label: '<strong>Severe:</strong> near complete destruction'
          }]
        }]
      }]

  firstTask: 'features'

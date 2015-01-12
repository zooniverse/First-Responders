# MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

module.exports =
  id: 'first_responder'
  background: './background.jpg'

  producer: 'Typhoon Haiyan (Yolanda)'
  title: 'The Planetary Response Network: Beta'
  summary: 'Join the relief effort to help crisis victims'
  description: 'Your help is needed to examine the affected areas and help humanitarian organizations provide aid.'

  organizations: [{
    image: './orgs/qcri.png'
    name: 'QCRI'
    web: 'http://www.qcri.com/'
    # description: 'TODO'
  }, {
    image: './orgs/planet-labs.png'
    name: 'Planet Labs'
    web: 'https://www.planet.com/'
    # description: 'TODO'
  }, {
    image: './orgs/dgf.png'
    name: 'Digital Globe Foundation'
    web: 'http://www.digitalglobefoundation.org/'
    # description: 'TODO'
  }]

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

  examples: require './field-guide'

# MagnifierPoint = require 'marking-surface/lib/tools/magnifier-point'

module.exports =
  id: 'first_responder'
  background: './background.jpg'

  producer: 'Typhoon Haiyan (Yolanda)'
  title: 'The Planetary Response Network: Beta'
  summary: 'Join the relief effort to help crisis victims'
  description: 'Your help is needed to examine the affected areas and help humanitarian organizations provide aid.'

  externalLinks:
    'Feedback': 'https://docs.google.com/forms/d/1TTAMMKpdzwFxxiyWKjllUk07qROQ6SnETHk8GZeCm9s/viewform'

  organizations: [{
    image: './orgs/qcri.png'
    name: 'QCRI'
    url: 'http://www.qcri.com/'
    description: 'Qatar Computing Research Institute QCRI) is a national research institute) established in 2010 by Qatar Foundation for Education, Science and Community Development. QCRI\'s vision is to be a global leader of computing research in identified areas that will bring positive impact to the lives of citizens and society.'
  }, {
    image: './orgs/planet-labs.png'
    name: 'Planet Labs'
    url: 'https://www.planet.com/'
    description: 'Planet creates commercial and humanitarian value with the market\'s most capable global imaging network. Fresh data from any place on Earth is foundational to solving commercial, environmental, and humanitarian challenges. Planet is committed to providing satellite imagery for humanitarian efforts by the Planetary Response Network.'
  }, {
    image: './orgs/dgf.png'
    name: 'Digital Globe Foundation'
    url: 'http://www.digitalglobefoundation.org/'
    description: 'The DigitalGlobe Foundation is a 501(c)(3) non-profit organization established on the belief that they have a unique opportunity to share DigitalGlobe\'s technology and resources to help train others to map, monitor, and measure the Earth. The DigitalGlobe Foundation is providing all pre-crisis imagery for PRN\'s pilot project.'
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

project = require 'zooniverse-readymade/current-project'

classifyPage = project.classifyPages[0]

classifyPage.decisionTree.el.insertAdjacentHTML 'beforeEnd', '''
  <p class="not-live-data-note">Your classifications of this real data from a past crisis are crucial to helping the analysis of future projects with live crisis data.</p>
'''

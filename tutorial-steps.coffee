#GhostMouse = require 'ghost-mouse'
User = require 'zooniverse/models/user'

isAbout = ([x, y], [idealX, idealY], give = 50) ->
  idealX - give < x < idealX + give and idealY - give < y < idealY + give

guideStyle =
  fill: 'transparent'
  stroke: 'white'
  strokeWidth: 2
  strokeDasharray: [4, 4]

# Might want this later as it's quite cool
###
ghostMouse = new GhostMouse
  events: true
  inverted: true
###

tutorialSteps =

  first:
    header: 'Welcome!'
    content: '''
      We need your help to identify damaged property and displaced people in real images of the aftermath of Typhoon Haiyan, which struck the Philippines in 2013. Your classifications will be used to help us analyze classifications from future crises.
      <BR /><BR />
      This short guide will show you how to spot and mark certain features.
    '''
    next: ->
      'tips'


  tips:
    header: 'Some general tips'
    content: '''
      Image quality (resolution) is mixed. We show all images to multiple people and then combine the inputs into an averaged result. We give this combined map to humanitarian organisations. Your best guess is all we need - don't worry if you miss something.
    '''
    next: ->
      'callOutToggle'


  # The attachment here is just so it shifts a little, so users re-focus
  callOutToggle:
    header: 'Change Detection'
    content: '''
      This is a satellite image of an affected area. Clicking the “Show Before” and “Show After” buttons switches between pre- and post-typhoon images.
      <BR /><BR />
      <EM>We only need you to mark things that have changed because of the typhoon.</EM>
    '''
    attachment: [0, 0.5, '.marking-surface', 0.05, 0.3]
    next: ->
      if @classifier.subjectViewer.toolOptions?.value is 'structural_damage'
        'markStructure'
      else
        'selectStructureTool'


  # not sure it's still a "tool" in this code -- is it a "feature"?
  # if so it will have to be changed in the tarp step too.
  selectStructureTool:
    content: '''
      We are looking for signs of damage to buildings and structures, and signs of where people might be gathering or living in temporary shelters.
      <BR /><BR />
      This image has a few damaged buildings.
    '''
    instruction: '''
      Select the “Structural Damage” tool on the right.
    '''
    attachment: [1, 0.5, '.marking-surface', 0.95, 0.8]
    #attachment: [1, 0.5, '.classify button[name="structural_damage"]', 0, 0.5]
    arrow: 'right'
    actionable: '[name="features"][value="structural_damage"] + .readymade-choice-clickable'
    next: 'change [name="features"][value="structural_damage"]': 'markStructure'


  # I'm not sure the "Next" part of this is right, because they have to classify
  # the amount of damage before it moves on, which is the second click required.
  markStructure:
    content: '''
      Let’s mark this damaged building and then rate its level of damage. <EM>Click the center of the damaged building, or the center of where it used to be.</EM>
    '''
    instruction: '''
      Click on the damaged building and estimate how severe the damage is.
    '''
    attachment: [0.5, 1, '.marking-surface', 0.45, 0.55]
    onLoad: ->
      @guide = @classifier.subjectViewer.markingSurface.addShape 'circle',
        r: 60
        transform: 'translate(370,300)'
      @guide.attr guideStyle

      @extantMarks = (mark for {mark} in @classifier.subjectViewer.markingSurface.tools)

    onUnload: ->
      @guide.remove()

    next:
      'click [name="readymade-dismiss-details"]': ->
        newMarks = (mark for {mark} in @classifier.subjectViewer.markingSurface.tools when mark not in @extantMarks)

        if newMarks.some((mark) -> isAbout [mark.x, mark.y], [370, 300])
          'selectTarpTool'
        else
          false

      'touchend .marking-surface': ->
        @._current.next['click [name="readymade-dismiss-details"]'].apply @, arguments



  selectTarpTool:
    content: '''
      In this image, there is a blue tarpaulin (or “tarp”; it’s like a tent) that someone may be using as a temporary roof. Marking the tarps helps aid organizations determine how many temporary shelters there are.
    '''
    instruction: '''
      Select the “Tarp/Temporary Shelter” tool.
    '''
    attachment:[1, 0.5, '.marking-surface', 0.95, 0.75]
    #attachment: [1, 0.5, '.classify button[name="tarp"]', 0, 0.5]
    arrow: 'right'
    actionable: '[name="features"][value="tarp"] + .readymade-choice-clickable'
    next: 'change [name="features"][value="tarp"]': 'markTarp'


  markTarp:
    content: '''
      <EM>In each image, mark the center of <STRONG>each</STRONG> tarp you see.</EM>
    '''
    instruction: '''
      Mark the center of the tarp.
    '''
    attachment: [1, 1, '.marking-surface', 0.4375, 0.5]
    onLoad: ->
      @guide = @classifier.subjectViewer.markingSurface.addShape 'circle',
        r: 60
        transform: 'translate(410, 220)'
      @guide.attr guideStyle

      @extantMarks = (mark for {mark} in @classifier.subjectViewer.markingSurface.tools)

    onUnload: ->
      @guide.remove()

    next:
      'mouseup .marking-surface': ->
        newMarks = (mark for {mark} in @classifier.subjectViewer.markingSurface.tools when mark not in @extantMarks)
        console.log m for m in newMarks

        if newMarks.some((mark) -> isAbout [mark.x, mark.y], [410, 220])
          'callOutOthers'
        else
          false

      'touchend .marking-surface': ->
        @._current.next['mouseup .marking-surface'].apply @, arguments


  callOutOthers:
    content: '''
      There are also other things we’re looking out for, like crowds, blocked roads, and flooding.
    '''
    attachment: [1, 0.5, '.marking-surface', 0.95, 0.65]
    arrow: 'right'
    next: 'callOutHelp'

  # as this step is currently the second-to-last one I'd like them to finish the classification here, possibly by
  # making them click "Done", but I'm unsure how to handle the Talk question, then, which I think they should
  # skip during the tutorial. Telling them to click "Done" and then "No" seems awkward. Can we do it automatically?
  callOutHelp:
    content: '''
      The spotter’s guide below gives tips and examples of important features, including how to tell a tarp from from other, similar structures.
    '''
    attachment: [0.5, 1, '.marking-surface', 0.5, 0.95]
    arrow: 'bottom'
    next: 'theEnd'

  # Currently skipping this step.
  callOutSignIn:
    content: '''
      Please sign in to help us process our data more efficiently.<BR />
      You’ll receive credit for your work, and be able to save images to discuss later.
    '''
    next: 'theEnd'


  # currently skipping this and the favorites step.
  # don't really like calling it a "favorite" anyway when it's an image of real destruction.
  callOutButSkipTalk:
    content: '''
      If you have questions or want to discuss this image, you can click “Yes” here to go to the community discussion area (which we call Talk).
    '''
    next: 'callOutFavorite'

  callOutFavorite:
    content: '''
      If you find a particularly interesting image, click this star before you submit your classification.
      You’ll be able to find it later in your collections in Talk.
    '''
    next: 'theEnd'



  theEnd:
    content: '''
      Each image is reviewed by several volunteers, so don’t be discouraged by a difficult one.
      Just try your best, and thanks.

      Click “Next” to start tagging!
    '''


module.exports = tutorialSteps

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
      In the aftermath of Typhoon Haiyan (aka Yolanda), we need your help to identify property damage and displaced people in the Phillippines.
      <BR /><BR />
	  This short guide will show you how to spot and mark certain features.
    '''
    next: ->
      'tips'
      

  tips:
    header: 'Some general tips'
    content: '''
      Some of the images you’ll see are high resolution, and others are lower resolution. We show each image to multiple people and then combine the inputs to provide information to humanitarian organizations. So it’s okay if you’re not always certain – your best guess is very helpful.
    '''
    next: ->
      'callOutToggle'
        
  
  # The attachment here is just so it shifts a little, so users re-focus  
  callOutToggle:
    header: 'Change Detection'
    content: '''
	  This is a satellite image of an affected area. Clicking the “Show Before” and “Show After” buttons switches between pre- and post-typhoon images.
      <BR /><BR />
	  Use the before images to tell whether something has changed due to the typhoon and should be marked. <EM>If it looks damaged even in the before image, you don’t need to mark it.</EM>
    '''
    attachment: [0, 0.5, '.marking-surface', 0.05, 0.3]
    next: ->
      if @classifier.surface.tool::name is 'structural_damage'
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
    actionable: '[name="tool"][value="structural_damage"]'
    next: 'click [name="tool"][value="structural_damage"]': 'markStructure'
    

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
      @guide = @classifier.surface.addShape 'circle',
        r: 60
        transform: 'translate(370,300)'
      @guide.attr guideStyle
      
      @extantMarks = (mark for mark in @classifier.surface.marks)
      
    onUnload: ->
      @guide.remove()
      
    next:
      'mouseup .marking-surface': ->
        newMarks = (mark for mark in @classifier.surface.marks when mark not in @extantMarks)
  
        if newMarks.some((mark) -> isAbout mark.center, [370, 300])
          'selectTarpTool'
        else
          false

      'touchend .marking-surface': ->
        @._current.next['mouseup .marking-surface'].apply @, arguments



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
    actionable: '[name="tool"][value="tarp"]'
    next: 'click [name="tool"][value="tarp"]': 'markTarp'


  markTarp:
    content: '''
      In each image, mark the center of each tarp you see.
    '''
    instruction: '''
      Mark the center of the tarp.
    '''
    attachment: [1, 1, '.marking-surface', 0.4375, 0.5]
    onLoad: ->
      @guide = @classifier.surface.addShape 'circle',
        r: 60
        transform: 'translate(410, 220)'
      @guide.attr guideStyle
      
      @extantMarks = (mark for mark in @classifier.surface.marks)
      
    onUnload: ->
      @guide.remove()
      
    next:
      'mouseup .marking-surface': ->
        newMarks = (mark for mark in @classifier.surface.marks when mark not in @extantMarks)
  
        if newMarks.some((mark) -> isAbout mark.center, [370, 300])
          'callOutOthers'
        else
          false

      'touchend .marking-surface': ->
        @._current.next['mouseup .marking-surface'].apply @, arguments


  callOutOthers:
    content: '''
      There are also other things we’re looking out for, like crowds, temporary shelters, blocked roads, and flooding.
    '''
    attachment: [1, 0.5, '.marking-surface', 0.95, 0.65]
    arrow: 'right'
    next: 'callOutHelp'


  callOutHelp:
    content: '''
      The spotter’s guide below shows examples of important features, including how to tell a tarp apart from a permanent roof that’s a tarp-like color. 
    '''
    attachment: [0.5, 1, '.marking-surface', 0.5, 0.95]
    arrow: 'bottom'
    next: 'callOutSignIn'


  callOutSignIn:
    content: '''
      Please sign in to help us process our data more efficiently.
      You’ll receive credit for your work, and be able to mark images as "favorites" for later.
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
      You’ll be able to find it later in your Favorites collection in Talk.
    '''
    next: 'theEnd'



  theEnd:
    content: '''
      Each image is reviewed by several volunteers, so don’t be discouraged by a difficult one.
      Just try your best, and thanks. 

      Click “Next” to start tagging!
    '''
    
            
module.exports = tutorialSteps

translate = window.translate = require 'zooniverse/lib/translate'

translate.strings.en['readymade.favorite'] = 'Save'
translate.strings.en['readymade.favoriteIcon'] = '<i class="fa fa-star-o readymade-clickable-not-checked"></i>'
translate.strings.en['readymade.favoriteIconChecked'] = '<i class="fa fa-star readymade-clickable-checked" style="color: orangered;"></i>'

for element in document.querySelectorAll "[#{translate.attr}]"
  translate.refresh element

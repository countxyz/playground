class ImageEditor.app

  'use strict'

  helper = ImageEditor.helper

  constructor: (image) ->
    @image = $(image).get 0
    @init()

  init: ->
    @imageContainer()
    @containerProfile()
    @mousedownEvents()

  imageContainer: ->
    helper.resizeHandles @image
    @container = $(@image).parent '.resize-container'

  mousedownEvents: ->

  containerProfile: ->

imageEditor = new ImageEditor.app $('#resize-image')

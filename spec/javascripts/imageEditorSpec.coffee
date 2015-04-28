describe 'ImageEditor', ->
  imageEditor    = null
  imageEditorApp = null

  beforeEach ->
    MagicLamp.load 'users/show'
    imageEditor    = {}
    imageEditorApp = new ImageEditor.app $('#resize-image')

  describe 'Initial State', ->
    it 'has image', ->
      expect(imageEditorApp.image.src).toMatch /\S*bill-lumbergh\S*.jpg/

  describe 'Image container and handles', ->
    it 'wraps image with a container', ->
      expect($('.resize-container')).toBeInDOM()

    it 'attaches a resize handle for each corner', ->
      expect($('.resize-handle-nw')).toBeInDOM()
      expect($('.resize-handle-ne')).toBeInDOM()
      expect($('.resize-handle-sw')).toBeInDOM()
      expect($('.resize-handle-se')).toBeInDOM()

  describe 'Resizing Container', ->

    describe 'Saving original container state', ->
      it 'saves the original container width', ->


    # it 'resizes the image container', ->
    #   spyEvent = spyOnEvent '.resize-handle', 'mousedown'
    #   $('.resize-handle').mousedown (event) -> event.preventDefault()
    #   $('.resize-handle').mousedown
    #   expect('mousedown').toHaveBeenPreventedOn '.resize-handle'
    #   expect(spyEvent).toHaveBeenPrevented()

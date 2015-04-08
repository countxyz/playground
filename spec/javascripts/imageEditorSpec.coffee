describe 'ImageEditor', ->
  imageEditor = null

  beforeEach ->
    loadFixtures 'image-editor.html'
    imageEditor = new ImageEditor
    imageEditor.resizeableImage $('.resize-image')

  describe 'Resize Container', ->
    it 'wraps image with a container', ->
      expect($('.resize-container')).toBeInDOM()

  describe 'Resize Handles', ->
    it 'attaches a resize handle for each corner', ->
      expect($('.resize-handle-nw')).toBeInDOM
      expect($('.resize-handle-ne')).toBeInDOM
      expect($('.resize-handle-sw')).toBeInDOM
      expect($('.resize-handle-se')).toBeInDOM

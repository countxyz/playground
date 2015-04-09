describe('ImageEditor', function() {

  beforeEach(function() {
    loadFixtures 'image-editor.html'
    resizeableImage($('.resize-image'));
  });

  describe('Resize Container', function() {
    it('wraps image with a container', function() {
      expect($('.resize-container')).toBeInDOM();
    });
  });

  describe('Resize Handles', function() {
    it('attaches a resize handle for each corner', function() {
      expect($('.resize-handle-nw')).toBeInDOM;
      expect($('.resize-handle-ne')).toBeInDOM;
      expect($('.resize-handle-sw')).toBeInDOM;
      expect($('.resize-handle-se')).toBeInDOM;
    });
  });
});

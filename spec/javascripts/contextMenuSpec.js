describe('Context Menu', function() {
  beforeEach(function() {
    MagicLamp.load('tasks/index', 'tasks/context_menu');
  });

  it('does not show context menu when page is loaded', function() {
    expect($('#context-menu')).toBeHidden();
  });

  it('displays context menu on right click', function() {
    $('.task').trigger('contextmenu');
    expect($('#context-menu')).toBeVisible();
  });
});

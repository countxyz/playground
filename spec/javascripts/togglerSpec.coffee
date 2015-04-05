describe 'Task detail toggler', ->
  toggler = null
  beforeEach -> toggler = new Toggler

  describe 'clicking a show link', ->
    it 'shows the task description', ->
      MagicLamp.load 'tasks/index'
      toggler.init()
      $('.detail-toggle').click()
      expect($('.detail')).not.toHaveClass 'hidden'

describe 'clicking a show description link', ->
  toggler = null

  beforeEach ->
    toggler = new Toggler $('.detail-toggle')
    loadFixtures 'task-index.html'
    $('.detail-toggle').click()

  it 'shows the task description', ->
    expect($('.detail')).not.toHaveClass 'hidden'

  it 'changes the link action to hide', ->
    expect($('.detail-toggle')).toHaveText 'Hide Details'

  describe 'clicking the link again', ->
    beforeEach -> $('.detail-toggle').click()

    it 'hides the description', ->
      expect($('.detail')).toHaveClass 'hidden'

    it 'Changes the link action back to Show', ->
      expect($('.detail-toggle')).toHaveText 'Show Details'

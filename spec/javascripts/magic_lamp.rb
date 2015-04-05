MagicLamp.fixture do
  @tasks = Task.all
  render template: 'tasks/index'
end

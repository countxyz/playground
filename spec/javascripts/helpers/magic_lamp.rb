MagicLamp.define controller: TasksController do
  fixture do
    current_user = User.first
    @tasks = current_user.tasks
    render :index
  end
end

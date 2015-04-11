MagicLamp.fixture controller: UsersController do
  current_user = User.first
  @user        = current_user
  render :show
end

MagicLamp.define controller: TasksController do
  fixture do
    current_user = User.first
    @tasks       = current_user.tasks
    render :index
  end

  fixture do
    current_user = User.first
    @tasks       = current_user.tasks
    render partial: 'context_menu'
  end
end

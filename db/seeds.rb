User.destroy_all
Task.unscoped.destroy_all

include Sprig::Helpers

sprig [User, Task]

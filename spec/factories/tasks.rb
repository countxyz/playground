FactoryGirl.define do
  factory :task do
    title       'Task Title'
    description 'Task Description'
    complete    false
    user
  end
end

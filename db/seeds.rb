User.destroy_all
user = User.create(email: 'user@example.com', password: 'password',
  password_confirmation: 'password')
user.save

Task.destroy_all
Task.create(title: 'Go To Grocery', description: 'Drive', user: user,
  deadline: Date.today + 2.weeks)
Task.create(title: 'Type Some Code', description: 'Ruby', user: user,
  deadline: Date.today + 3.weeks)
Task.create(title: 'Build An App', description: 'Rails', user: user,
  deadline: 3.days.ago, completed: 5.days.ago)

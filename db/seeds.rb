User.destroy_all
user = User.create(email: 'user@example.com', password: 'password',
  password_confirmation: 'password')
user.save

Task.unscoped.destroy_all
Task.create(title: 'Go To Grocery', user: user, deadline: Date.today + 2.weeks,
  description: 'Drive there. Make sure to get cookies.')

Task.create(title: 'Type Some Code', description: 'Use Ruby', user: user,
  deadline: Date.today + 3.weeks)

Task.create(title: 'Build An App', description: ' With Rails', user: user,
  deadline: 3.days.ago, complete: true, completed_at: 5.days.ago)

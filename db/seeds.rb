User.destroy_all
user = User.create(email: 'user@example.com', password: 'password',
  password_confirmation: 'password')
user.save

Task.destroy_all
Task.create description: 'Go To Grocery',  user: user
Task.create description: 'Type Some Code', user: user
Task.create description: 'Build An App',   user: user

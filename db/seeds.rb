User.destroy_all
User.create(email: 'user@example.com', password: 'password',
  password_confirmation: 'password')

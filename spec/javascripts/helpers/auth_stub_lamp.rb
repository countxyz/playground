module AuthStub
  def current_user
    @current_user ||= User.create!(
      email:                 'aladdin@example.com',
      password:              'password',
      password_confirmation: 'password'
    )
  end
end

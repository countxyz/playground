def signin_as!(user)
  visit '/'
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

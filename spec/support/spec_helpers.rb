def signin_as!(user)
  visit '/'
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

def delete_leaderboard board_name
  after_spec = Leaderboard.new board_name
  after_spec.delete_leaderboard
end

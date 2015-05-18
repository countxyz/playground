def delete_leaderboard board_name
  after_spec = Leaderboard.new board_name
  after_spec.delete_leaderboard
end

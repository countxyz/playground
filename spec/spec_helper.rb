RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }

  config.order = :random
  config.run_all_when_everything_filtered = true

  Kernel.srand config.seed
end

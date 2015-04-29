require 'rails_helper'

RSpec.describe 'Slugs' do
  it 'has slug for account name' do
    expect(get: 'accounts/vandalay').to route_to(
      controller: 'accounts', action: 'show', id: 'vandalay' )
  end
end

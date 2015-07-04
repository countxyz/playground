require 'rails_helper'

RSpec.feature 'Footer' do
  before { visit '/' }

  scenario 'Copyright' do
    expect(page).
      to have_content 'Copyright © 2015 Efren Aguirre / skeptoid@gmail.com'

    expect(page).to have_content 'Do What the Fuck You Want to Public License'
    expect(page).to have_content 'See wtfpl for more details'
  end

  scenario 'Links' do
    expect(page).
      to have_selector 'a[@href="http://www.wtfpl.net"][target="_blank"]'

    expect(page).
      to have_selector 'a[@href="https://github.com/countxyz"][target="_blank"]'
  end
end

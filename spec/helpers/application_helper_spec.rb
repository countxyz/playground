require 'rails_helper'

RSpec.describe ApplicationHelper do

  describe 'Page Title' do
    it 'displays base title without page title' do
      expect(helper.base_title).to eq 'Playground'
    end

    it 'displays full title' do
      expect(helper.full_title 'Sign Up').to eq 'Playground | Sign Up'
    end
  end

  describe 'Data Format' do
    it "is 'N/A' when data not given" do
      expect(helper.data_format nil).to eq 'N/A'
    end
  end
end

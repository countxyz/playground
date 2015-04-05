require 'rails_helper'

RSpec.describe TimeHelper do

  describe 'Task Time Format' do
    it 'formats task times when provided' do
      datetime = Time.new(2015, 5, 18, 0, 0, 0).utc
      expect(helper.task_time_format datetime).to eq 'May 18, 2015  4:00 am UTC'
    end

    it "formats nil datetimes with 'N/A'" do
      expect(helper.task_time_format nil).to eq 'N/A'
    end
  end
end

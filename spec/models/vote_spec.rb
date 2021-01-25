require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'Testing associations' do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end
end

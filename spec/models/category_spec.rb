require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Testing validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(16) }
    it { should validate_presence_of(:priority) }
    it { should validate_numericality_of(:priority).only_integer.is_less_than_or_equal_to(9) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Testing associations' do
    it { should have_many(:articles) }
  end

  describe 'Testing scopes' do
    let!(:cat1) { Category.create(name: 'category1', priority: 9) }
    let!(:cat2) { Category.create(name: 'category2', priority: 1) }

    describe '.prioritize' do
      it 'returns categories collection ordered by priority' do
        expect(Category.prioritize.first).to eq cat2
      end

      it 'returns empty categories collection array if there is no category object' do
        Category.destroy_all
        expect(Category.prioritize).to eq []
      end
    end
  end
end

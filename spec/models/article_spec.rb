require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'Testing associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe 'Testing validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(50) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(10).is_at_most(1000) }
    it { should validate_presence_of(:category_id) }
  end
end

RSpec.describe Article, type: :model do
  describe 'Testing scopes' do
    let!(:user1) { User.create(name: 'testuser1') }
    let!(:user2) { User.create(name: 'testuser2') }
    let!(:cat1) { Category.create(name: 'category1', priority: 3) }
    let!(:cat2) { Category.create(name: 'category2', priority: 1) }
    let!(:article1) do
      Article.create(title: 'Article1', text: 'description1', author_id: user1.id, category_id: cat1.id)
    end
    let!(:article2) do
      Article.create(title: 'Article2', text: 'description2', author_id: user2.id, category_id: cat2.id)
    end

    describe '.order_by_created' do
      it 'collects ordered by created_at' do
        expect(Article.order_by_created.second).to eq article1
      end

      it 'return empty collection array if article objects do not exist' do
        Article.destroy_all
        expect(Article.order_by_created).to eq []
      end
    end

    describe '.latest' do
      it 'returns the latest article object' do
        expect(Article.latest).to eq article2
      end

      it 'return empty collection array if article objects do not exist' do
        Article.destroy_all
        expect(Article.latest).to eq []
      end
    end
  end
end

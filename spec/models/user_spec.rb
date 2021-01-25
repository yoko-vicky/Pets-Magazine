require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Testing validations' do
    msg = "can user only letters, numbers and underscores '_'"
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
    it { should validate_uniqueness_of(:name) }
    it { should allow_value('Test123').for(:name).with_message(msg) }
  end
  describe 'Testing associations' do
    it { should have_many(:articles).dependent(:destroy).with_foreign_key('author_id') }
    it { should have_many(:votes).dependent(:destroy) }
  end
  describe 'Testing instance methods' do
    let!(:user1) { User.create(name: 'testuser1') }
    let!(:user2) { User.create(name: 'testuser2') }
    let!(:cat1) { Category.create(name: 'category1', priority: 9) }
    let!(:cat2) { Category.create(name: 'category2', priority: 1) }
    let!(:article1) do
      Article.create(title: 'Article1', text: 'description1', author_id: user1.id, category_id: cat1.id)
    end
    let!(:article2) do
      Article.create(title: 'Article2', text: 'description2', author_id: user2.id, category_id: cat2.id)
    end
    let!(:article3) do
      Article.create(title: 'Article3', text: 'description3', author_id: user1.id, category_id: cat2.id)
    end
    let!(:vote1) { Vote.create(user_id: user1.id, article_id: article1.id) }
    let!(:vote2) { Vote.create(user_id: user2.id, article_id: article2.id) }

    describe '#already_voted?' do
      it 'returns true if the user voted the given article' do
        expect(user1.already_voted?(article1)).to eq true
      end

      it 'returns false if the user did not vote the given article' do
        expect(user1.already_voted?(article2)).to eq false
      end
    end

    describe '#ordered_articles' do
      it 'returns articles belonging to the user ordered by created date' do
        expect(user1.ordered_articles.first).to eq article3
      end

      it 'returns empty articles collection array if there is no user' do
        User.destroy_all
        expect(user1.ordered_articles).to eq []
      end
    end
  end
end

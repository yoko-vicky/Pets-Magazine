require 'rails_helper'

# rubocop:disable Layout/LineLength
RSpec.describe ApplicationHelper, type: :helper do
  let!(:user1) { User.create(name: 'testuser1') }
  let!(:user2) { User.create(name: 'testuser2') }
  let!(:current_user) { user1 }
  let!(:cat1) { Category.create(name: 'category1', priority: 3) }
  let!(:cat2) { Category.create(name: 'category2', priority: 1) }
  let!(:article1) do
    Article.create(title: 'Article1', text: 'description1', author_id: user1.id, category_id: cat1.id)
  end
  let!(:article2) do
    Article.create(title: 'Article2', text: 'description2', author_id: user2.id, category_id: cat2.id)
  end
  let!(:article3) do
    Article.create(title: 'Article3', text: 'description3', author_id: user2.id, category_id: cat1.id)
  end
  let!(:vote1) { Vote.create(user_id: user1.id, article_id: article1.id) }
  let!(:vote2) { Vote.create(user_id: user2.id, article_id: article2.id) }
  let!(:vote3) { Vote.create(user_id: user2.id, article_id: article1.id) }

  describe '#find_vote_id' do
    it 'returns vote_id with the current_user and the given article_id' do
      expect(find_vote_id(article1.id)).to eq(vote1.id)
    end

    it 'returns nil if there is no vote with the current_user and the given article_id' do
      expect(find_vote_id(article2.id)).to eq(nil)
    end
  end

  describe '#votes_size' do
    it 'returns the number of votes of the given article' do
      expect(votes_size(article1.id)).to eq(2)
    end

    it 'returns zero if there is no vote in the given article' do
      expect(votes_size(article3.id)).to eq(0)
    end
  end

  describe '#this_year' do
    it 'returns the number of current year' do
      current_year = Time.new.year
      expect(this_year).to eq(current_year)
    end
  end

  describe '#distance_time' do
    it 'returns the number of distance time from the given time' do
      from = Time.at(0)
      expect(distance_time(from)).to eq('about 51 years')
    end

    it 'occurs an ArgumentError if a from is not given' do
      expect { distance_time }.to raise_error(ArgumentError)
    end
  end

  describe '#excerpt' do
    let(:text) do
      'amet nisl purus in mollis nunc sed id semper risus in hendrerit gravida rutrum quisque non tellus orci ac auctor augue mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse in est ante in nibh mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit amet nulla facilisi'
    end

    it 'returns truncated text with 160 letters of the given text' do
      expect(excerpt(text).length).to eq(160)
    end

    it 'occurs an ArgumentError if a from is not given' do
      expect { excerpt }.to raise_error(ArgumentError)
    end
  end

  describe '#excerpt_short' do
    let(:text) do
      'amet nisl purus in mollis nunc sed id semper risus in hendrerit gravida rutrum quisque non tellus orci ac auctor augue mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse in est ante in nibh mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit amet nulla facilisi'
    end

    it 'returns truncated text with 100 letters of the given text' do
      expect(excerpt_short(text).length).to eq(100)
    end

    it 'occurs an ArgumentError if a from is not given' do
      expect { excerpt_short }.to raise_error(ArgumentError)
    end
  end
end

# rubocop:enable Layout/LineLength

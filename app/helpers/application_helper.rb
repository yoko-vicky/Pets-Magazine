module ApplicationHelper
  def find_vote_id(article_id)
    return unless article_id

    vote = Vote.includes(%i[user article]).where(user_id: current_user.id, article_id: article_id).first
    return unless vote

    vote.id
  end

  def votes_size(article_id)
    return unless article_id

    Vote.includes(:article).where(article_id: article_id).size
  end

  def this_year
    Time.new.year
  end

  def distance_time(from)
    return unless from

    time_ago_in_words(from)
  end

  def excerpt(text)
    return unless text

    sanitize(truncate(text, length: 160, omission: '...'))
  end

  def excerpt_short(text)
    return unless text

    sanitize(truncate(text, length: 100, omission: '...'))
  end
end

module ArticlesHelper
  def articles_image(article)
    if article.image.exists?
      image_tag(article.image.url, class: 'articles__image')
    else
      image_tag('no_img.jpg', class: 'articles__image')
    end
  end

  def voted_star(article)
    if login? && current_user.already_voted?(article.id)
      link_to(article_vote_path(article_id: article.id,
                                id: find_vote_id(article.id)), method: :delete, class: 'articles__star') do
        content_tag(:i, nil, class: 'fas fa-star')
      end
    else
      link_to(article_votes_path(article), method: :create, class: 'articles__star') do
        content_tag(:i, nil, class: 'far fa-star')
      end
    end
  end

  def my_favorites_articles(articles)
    if articles.any?
      content_tag(:div, class: 'articles') do
        render articles
      end
    else
      render 'shared/notfound'
    end
  end

  def all_articles(articles)
    if articles.any?
      content_tag(:div, class: 'articles') do
        render articles
      end +
        content_tag(:div, class: 'btns') do
          link_to('Create a new article', new_article_path, class: 'btn btn-info')
        end
    else
      render 'shared/notfound'
    end
  end

  def single_article_image(article)
    image_tag(article.image.url, class: 'article__thumb') if article.image.exists?
  end

  def edit_btns_for_single_post(article)
    return if current_user != article.author

    content_tag(:div, class: 'btns') do
      link_to('Edit', edit_article_path(article), class: 'btn btn-info') +
        link_to('Delete', article_path(article), method: :delete,
                                                 data: { confirm: 'Are you sure?' }, class: 'btn btn-danger')
    end
  end

  def current_image_thumb(article)
    return unless article.image.exists?

    image_tag(article.image.url(:thumb), class: 'field__thumb')
  end
end

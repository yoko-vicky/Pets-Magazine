module CategoriesHelper
  def most_popular_article_image(most_popular_article)
    if most_popular_article.image.exists?
      image_tag(most_popular_article.image.url, class: 'featured__image')
    else
      image_tag('no_img.jpg', class: 'featured__image')
    end
  end

  def render_featured_area(most_popular_article)
    if most_popular_article
      render 'categories/featured'
    else
      render 'shared/notfound'
    end
  end

  def category_articles_image(category)
    category.articles.latest.image.exists? ? category.articles.latest.image.url : 'no_img.jpg'
  end

  def single_category_view(category)
    return unless category.articles.any?

    content_tag(:div, class: 'categories__item') do
      content_tag(:div, class: 'categories__images') do
        image_tag(category_articles_image(category), class: 'categories__image')
      end +
        content_tag(:div, class: 'categories__texts') do
          content_tag(:h2, class: 'categories__title') do
            content_tag(:span) do
              link_to(category.name, category_path(category))
            end
          end +
            content_tag(:h3, class: 'categories__subtitle') do
              link_to(category.articles.latest.title, article_path(category.articles.latest))
            end
        end
    end
  end

  def all_categories(categories)
    return unless categories.any?

    content_tag(:div, class: 'categories') do
      render categories
    end
  end

  def category_articles(articles)
    if articles.any?
      content_tag(:div, class: 'articles') do
        render partial: 'articles/article', collection: @articles
      end
    else
      render 'shared/notfound'
    end
  end
end

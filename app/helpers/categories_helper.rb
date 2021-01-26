module CategoriesHelper
  def category_articles_image(category)
    category.articles.latest.image.exists? ? category.articles.latest.image.url : 'no_img.jpg'
  end

  def most_popular_article_image(most_popular_article)
    most_popular_article.image.exists? ? most_popular_article.image.url : 'no_img.jpg'
  end

  def render_featured_area(most_popular_article)
    most_popular_article ? 'categories/featured' : 'shared/notfound'
  end
end

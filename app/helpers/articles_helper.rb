module ArticlesHelper
  def articles_image(article)
    article.image.exists? ? article.image.url : 'no_img.jpg'
  end
end

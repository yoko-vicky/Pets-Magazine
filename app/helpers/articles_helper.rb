module ArticlesHelper
  def articles_image(article)
    if article.image.exists?
      article.image.url
    else
      'no_img.jpg'
    end
  end
end

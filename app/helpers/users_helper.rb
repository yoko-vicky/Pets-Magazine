module UsersHelper
  def all_users(users)
    return unless users.any?

    content_tag(:div, class: 'users') do
      render(partial: 'user', collection: users)
    end
  end

  def account_settings(user)
    return if current_user != user

    content_tag(:div, class: 'my-settings') do
      content_tag(:div, 'Account Settings', class: 'my-settings__title') +
        content_tag(:div, class: 'btns my-settings__btns') do
          link_to('My favorites', my_favorites_path, class: 'btn btn-standout') +
            link_to('Edit Name', edit_user_path(user), class: 'btn btn-info') +
            link_to('Delete My Account', user_path(user), method: :delete,
                                                          data: { confirm: 'Are you sure to delete this user?' },
                                                          class: 'btn btn-danger')
        end
    end
  end

  def users_articles(articles)
    if articles.any?
      content_tag(:div, class: 'articles') do
        render(partial: 'articles/article', collection: @articles)
      end
    else
      render 'shared/notfound'
    end
  end
end

# rubocop:disable Metrics/ModuleLength
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

  def flash_messages(flash)
    if !flash.alert.nil?
      content_tag(:div, alert, class: 'messages__item alert')
    elsif !flash.notice.nil?
      content_tag(:div, notice, class: 'messages__item notice')
    end
  end

  def header_menu_for_login_user
    return unless login?

    content_tag(:li, class: 'header__nav__item') do
      link_to('Create a category', new_category_path,
              class: current_page?(new_category_path) ? 'header__nav__link active' : 'header__nav__link')
    end +
      content_tag(:li, class: 'header__nav__item') do
        link_to('My favorites', my_favorites_path,
                class: current_page?(my_favorites_path) ? 'header__nav__link active' : 'header__nav__link')
      end
  end

  def login_logout_menu
    if login? && current_user
      content_tag(:li, class: 'header__nav__item') do
        link_to(current_user.name, user_path(current_user), class: 'header__nav__username')
      end +
        content_tag(:li, class: 'header__nav__item') do
          link_to('Logout', logout_path, method: :delete, class: 'header__nav__link')
        end
    else
      content_tag(:li, class: 'header__nav__item') do
        link_to('Register', signup_path,
                class: current_page?(signup_path) ? 'header__nav__link active' : 'header__nav__link')
      end +
        content_tag(:li, class: 'header__nav__item') do
          link_to('Login', login_path,
                  class: current_page?(login_path) ? 'header__nav__link active' : 'header__nav__link')
        end
    end
  end

  def header_home_class
    current_page?(root_path) ? 'header__nav__link active' : 'header__nav__link'
  end

  def header_new_article_class
    current_page?(new_article_path) ? 'header__nav__link active' : 'header__nav__link'
  end

  def header_all_article_class
    current_page?(articles_path) ? 'header__nav__link active' : 'header__nav__link'
  end

  def side_home_class
    current_page?(root_path) ? 'sidemenu__link active' : 'sidemenu__link'
  end

  def side_new_article_class
    current_page?(new_article_path) ? 'sidemenu__link active' : 'sidemenu__link'
  end

  def side_category_menu
    return unless categories.any?

    content_tag(:ul) do
      categories.each do |category|
        concat(content_tag(:li, class: 'sidemenu__item') do
          link_to(category.name, category_path(category),
                  class: current_page?(category_path(category)) ? 'sidemenu__link active' : 'sidemenu__link')
        end)
      end
    end
  end

  def sidemenu_for_not_login_user
    return if login?

    content_tag(:li, class: 'sidemenu__item') do
      link_to('Login', login_path, class: current_page?(login_path) ? 'sidemenu__link active' : 'sidemenu__link')
    end +
      content_tag(:li, class: 'sidemenu__item') do
        link_to('Register', signup_path, class: current_page?(signup_path) ? 'sidemenu__link active' : 'sidemenu__link')
      end
  end

  def sidemenu_for_login_user
    return unless login? && current_user

    content_tag(:div, class: 'sidemenu__info') do
      image_tag('user.jpg', class: 'sidemenu__avatar', alt: 'username') +
        content_tag(:div, current_user.name, class: 'sidemenu__name')
    end +
      content_tag(:nav, class: 'sidemenu__nav') do
        content_tag(:ul, class: 'sidemenu__list') do
          content_tag(:li, class: 'sidemenu__item') do
            link_to('Dashboard', '#', class: 'sidemenu__link')
          end +
            content_tag(:li, class: 'sidemenu__item') do
              link_to('Your favorites', my_favorites_path, class: 'sidemenu__link')
            end +
            content_tag(:li, class: 'sidemenu__item') do
              link_to('Replies', '#', class: 'sidemenu__link')
            end +
            content_tag(:li, class: 'sidemenu__item') do
              link_to('Account', user_path(current_user),
                      class: current_page?(user_path(current_user)) ? 'sidemenu__link active' : 'sidemenu__link')
            end +
            content_tag(:li, class: 'sidemenu__item') do
              link_to('Log out', logout_path, method: :delete, class: 'sidemenu__link')
            end
        end
      end
  end

  def error_messages(obj)
    return unless obj.errors.any?

    content_tag(:ul, class: 'errors') do
      obj.errors.full_messages.each do |msg|
        concat(content_tag(:li, class: 'errors__item') do
          msg
        end)
      end
    end
  end
end
# rubocop:enable Metrics/ModuleLength

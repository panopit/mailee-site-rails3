module SiteHelper
  def env_path
    Rails.env == 'development' ? 'mailee.me:8081' : 'mailee.me'
  end
  def selected(current)
    selected_menu == current ? 'current_view' : ''
  end

  def signup_iframe_path; "http://signup.#{env_path}/signup/new"; end
  def blog_path;          'http://blog.mailee.me';                end
  def twitter_path;       'http://twitter.com/maileeme';          end
  def support_mail;       'mailto:suporte@mailee.me';             end
  def commercial_mail;    'mailto:comercial@mailee.me';           end
    
  def help_path(page=nil)
    "http://help.mailee.me/#{page}"
  end
end

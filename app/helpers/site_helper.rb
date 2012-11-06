module SiteHelper

  def kase img, name, bio, about, desc
    render :partial => 'kase', :locals => {:img => img, :name => name, :bio => bio, :about => about, :desc => desc}
  end
  
  def env_path
    case Rails.env
      when 'development'
         'wizee.net'
      when 'preproduction'
        'maileebeta.me'
      when 'production'
        'mailee.me'
    end
  end
  def selected(current);    selected_menu.to_s == current.to_s ? 'current_view' : '';             end
  def signup_iframe_path;   "https://signups.#{env_path}/signup/new?referrer=#{params[:referrer]}"; end

  def global_login;         'https://signups.mailee.me/site_sessions/new' end
  def blog_path;            'http://blog.mailee.me' end
  def twitter_path;         'http://twitter.com/maileeme' end
  def support_mail;         'mailto:suporte@mailee.me' end
  def commercial_mail;      'mailto:comercial@mailee.me' end
  def help_path(page=nil);  "http://help.mailee.me/#{page}" end
end

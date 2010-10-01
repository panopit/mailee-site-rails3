MaileeSiteRails3::Application.routes.draw do
=begin
  resource :site, :controller => 'site' do
    member do
      get :spam
      get :terms
      get :privacy
      get :best_practices
      get :tour
      get :prices
    end
  end
=end

  # Site paths
  post "mailee", :controller => :site, :action => :mailee
  get "trabalhando", :controller => :working_on, :action => :index
  get "politica_anti_spam(.html)", :controller => :site, :action => :spam, :as => :spam
  get "cadastro(.html)", :controller => :site, :action => :signup, :as => :signup
  get "termos_de_uso(.html)", :controller => :site, :action => :terms, :as => :terms
  get "politica_de_privacidade(.html)", :controller => :site, :action => :privacy, :as => :privacy
  get "melhores_praticas(.html)", :controller => :site, :action => :best_practices, :as => :best_practices
  get "recursos(.html)", :controller => :site, :action => :tour, :as => :tour
  get "precos(.html)", :controller => :site, :action => :prices, :as => :prices
  get "bad_browsers(.html)", :controller => :site, :action => :bad_browsers, :as => :bad_browsers
  # Mailee form paths
  get "form_ok(.html)", :controller => :site, :action => :form_ok, :as => :form_ok
  get "form_error(.html)", :controller => :site, :action => :form_error, :as => :form_error
  # Root path
  root :to => 'site#index'

=begin
  @support_mail                 = "mailto:suporte@mailee.me"
  @commercial_mail              = "mailto:comercial@mailee.me"
  env = "#HOST#"
  @help_path                    = "http://help.#{env}/"
  @template_creating_path       = "http://help.#{env}/templates_creating.html"
  @blog_path                    = "http://blog.mailee.me/"
  @twitter_path                 = "http://www.twitter.com/maileeme"
  @form_error_path              = "http://www.#{env}/form_error.html"
  @form_ok_path                 = "http://www.#{env}/form_ok.html"
  @mailee_signup_path           = "http://signup.#{env}/signup/new"
=end

end

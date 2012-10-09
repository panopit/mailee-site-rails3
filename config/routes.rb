MaileeSiteRails3::Application.routes.draw do

  get "cases(.html)", :controller => :site, :action => :cases, :as => :cases
  post "mailee", :controller => :site, :action => :mailee, :as => :mailee
  get "politica_anti_spam(.html)", :controller => :site, :action => :spam, :as => :spam
  get "cadastro(.html)", :controller => :site, :action => :signup, :as => :signup
  get "termos_de_uso(.html)", :controller => :site, :action => :terms, :as => :terms
  get "politica_de_privacidade(.html)", :controller => :site, :action => :privacy, :as => :privacy
  get "melhores_praticas(.html)", :controller => :site, :action => :best_practices, :as => :best_practices
  get "recursos(.html)", :controller => :site, :action => :tour, :as => :tour
  get "precos(.html)", :controller => :site, :action => :prices, :as => :prices
  get "bad_browsers(.html)", :controller => :site, :action => :bad_browsers, :as => :bad_browsers

  get "agencias(.html)", :controller => :site, :action => :agencies, :as => :agencies

  root :to => 'site#index'

end
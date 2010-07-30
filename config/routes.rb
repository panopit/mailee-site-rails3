MaileeSiteRails3::Application.routes.draw do
  get "working_on/index"
  get "trabalhando", :controller => :working_on, :action => :index
end

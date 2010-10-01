# encoding: utf-8
class SiteController < ApplicationController
  
  def index
  end

  def bad_browsers
    title "Navegador inválido"
  end

  def best_practices
    title "Melhores práticas"
  end

  def form_ok; end
  def form_error; end

  def prices
    title "Preços"
  end

  def privacy
    title "Política de Privacidade"
  end

  def signup
  end

  def spam
    title "Política Anti-SPAM"
  end

  def terms
    title "Termos de Uso"
  end

  def tour
    title "Principais recursos"
  end

  def mailee
    ok = 'http://www.google.com'
    error = 'http://www.yahoo.com'
    url = "http://mailee.mailee.me/go/add_contact_form"
    data = {:name => params[:name], :email => params[:email], :key => "f9b5d3", "list[]" => 22642, :url_ok => ok, :url_error => error}
    res = Net::HTTP.post_form(URI.parse(url), data)
    render :json => {:ok => res['location'] == ok}
    # %input{ :name => "key", :type => "hidden", :value =>  }
    # %input{ :name => "url_ok", :type => "hidden", :value => form_ok_url }
    # %input{ :name => "url_error", :type => "hidden", :value => form_error_url }
    # %input{ :name => "list[]", :type => "hidden", :value => "22642" }
  end
  
protected

  before_filter :set_defaults

  def set_defaults
    title "Email marketing com criador de templates, geolocalização e integração com redes sociais"
    @online = File.read('online.txt') == 'true' rescue false
  end

  def title(title)
    @title = "%s · Email Marketing 2.0 · Mailee.me" % title
  end

  helper_method :selected_menu, :body_id

  def selected_menu
    @selected_menu ||= action_name
  end

  #def body_id
  #  @body_id ||= selected_menu
  #end

end

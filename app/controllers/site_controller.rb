# encoding: utf-8
class SiteController < ApplicationController

  # caches_page :index, :tour, :bad_browsers, :privacy, :terms, :prices

  def index
  end

  def agencies
    # title "Agências"
    #render :layout => false
    render :status => :not_found, :nothing => true
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
    @referrer = params["referrer"]
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

  def cases
    title "Cases"
  end

  def mailee
    require 'net/http'
    ok = 'http://www.google.com'
    error = 'http://www.yahoo.com'
    url = 'http://mailee.mailee.me/go/add_contact_form'
    data = {:name => params[:name], :email => params[:email], :key => "f9b5d3", "list[]" => 22642, :url_ok => ok, :url_error => error}
    res = Net::HTTP.post_form(URI.parse(url), data)
    render :json => {:ok => res['location'] == ok}
  end

  # Sends the email via ajax.
  def contact
    Site.contact(params).deliver
    render :json => {:ok => true}.to_json
  rescue
    render :json => {:ok => false}.to_json
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

end

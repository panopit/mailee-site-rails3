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

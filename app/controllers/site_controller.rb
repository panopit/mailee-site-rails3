# encoding: utf-8
class SiteController < ApplicationController
  
  def index
    @body_id = :home
  end

  def bad_browsers
    title "Navegador inválido · Email Marketing 2.0 · Mailee.me"
    @body_id = :bad_browsers
  end

  def best_practices
    title "Melhores práticas · Email Marketing 2.0 · Mailee.me"
    @body_id = :best_practices
  end

  def form_ok; end
  def form_error; end

  def prices
    title "Preços · Email Marketing 2.0 · Mailee.me"
    @body_id = :prices
  end

  def privacy
    title "Política de Privacidade · Email Marketing 2.0 · Mailee.me"
    @body_id = :privacy_policy
  end

  def signup
    title "Email marketing com criador de templates, geolocalização e integração com redes sociais · Mailee.me"
  end

  def spam
    title "Política Anti-SPAM · Email Marketing 2.0 · Mailee.me"
    @body_id = :anti_spam_policy
  end

  def terms
    title "Termos de Uso · Email Marketing 2.0 · Mailee.me"
    @body_id = :terms_of_use
  end

  def tour
    title "Principais recursos · Email Marketing 2.0 · Mailee.me"
    @body_id = :resources
  end

protected

  before_filter :set_defaults

  def set_defaults
    title "Email marketing com criador de templates, geolocalização e integração com redes sociais · Mailee.me"
  end

  def title(title)
    @title = title
  end

  helper_method :selected_menu, :body_id

  def selected_menu
    @selected_menu ||= action_name
  end

  def body_id
    @body_id ||= selected_menu
  end

end

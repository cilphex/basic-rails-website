class ApplicationController < ActionController::Base
  include UserAuthentication

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_request
  before_filter :authenticate_admin
  before_filter :set_locale

  def set_current_request
    CurrentRequest.locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:match, /[a-z]{2}(-[a-z]{2})?/i).try(:[], 0)
    CurrentRequest.remote_ip = request.remote_ip
  end

  def set_locale
    locale = [
      current_user.try(:locale),     # Current user locale
      params[:locale],               # Query param locale
      cookies[:freebitcoin_locale],  # Session locale
      CurrentRequest.locale          # Request locale
    ].compact.first

    if I18n.available_locales.map(&:to_s).include?(locale)
      I18n.locale = locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json

  after_action :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def after_sign_in_path_for(admin)
      rails_admin.dashboard_path
  end

  protected
  def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end

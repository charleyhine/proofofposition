class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :lat_lng
  after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    #session[:previous_url] || inside_path
    inside_path
  end
  

  private
  
  def lat_lng
    cookie = cookies[:lat_lng]
    @lat_lng ||= cookie.split("|") if !cookie.nil?
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:stampable?) }
  end
end

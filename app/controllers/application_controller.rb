class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,                            :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,         :with => :render_not_found
    rescue_from ActionController::RoutingError,       :with => :render_not_found
    rescue_from ActionController::UnknownController,  :with => :render_not_found
    rescue_from ActionController::UnknownAction,      :with => :render_not_found
    rescue_from ArgumentError,                        :with => :render_unauthorized
  end

  private
  def render_not_found(exception)
     render :template => "/error/404.html.haml", :status => 404
  end

  def render_error(exception)
    render :template => "/error/500.html.haml", :status => 500 
  end

  def render_unauthorized(exception)
    render :template => "/error/401.html.haml", :status => 401
  end

end

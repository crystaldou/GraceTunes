class ErrorsController < ApplicationController
  def not_found
    render :status => 404, :formats => [:html]
    # Will render the app/views/errors/not_found.html.haml template
  end

  #def server_error
  #  render :status => 500, :formats => [:html]
  #end

  def unauthorized
    # Will render the app/views/errors/unauthorized.html.haml template
  end

  def error
    # Will render the app/views/errors/error.html.haml template
  end

  def the_exception
    @e ||= env["action_dispatch.exception"]
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter  :authorize, :except => :login
  session :session_key => '_arca_session_id' 
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '9c7d05aba77e9f7510a61df367d99a00'
  
#end

  # Pick a unique cookie name to distinguish our session data from others'
 
  protected
  def authorize
    unless Usuario.find_by_id(session[:usuario_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login" , :action => "login" )
    end
  end
end

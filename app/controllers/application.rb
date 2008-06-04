# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter  :authorize, :except => :login

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_arca_session_id'
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '9c7d05aba77e9f7510a61df367d99a00'

  protected

  def authorize
    unless Usuario.find_by_id(session[:usuario_id]) or Usuario.count == 0
      session[:original_uri] = request.request_uri
      flash[:notice] = "Por favor autentiquese en el sistema"
      redirect_to(:controller => "login" , :action => "login" )
    end

    if Usuario.count == 0
      if request.path_parameters[:action]=="agregar_usuario" and request.path_parameters[:controller]=="login"
        #nothing
      else
        session[:original_uri] = request.request_uri
        flash[:notice] = "Esta es la primera vez que ha iniciado la aplicación, por favor cree un usuario"
        redirect_to(:controller => "login" , :action => "agregar_usuario" )
      end
    end
  end
end

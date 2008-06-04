class LoginController < ApplicationController
  #  before_filter :authorize, :except => :login

  def agregar_usuario
    @usuario = Usuario.new(params[:usuario])
    if request.post? and @usuario.save
      flash[:notice] = "Usuario #{@usuario.nombre} creado"
      @usuario = Usuario.new
      uri = session[:original_uri]
      session[:original_uri] = nil
      redirect_to( uri ||{ :action => "lista_usuarios"} )
    end

  end

  def login
    session[:usuario_id] = nil
    if Usuario.count == 0
      redirect_to(:action => 'agregar_usuario')
    elsif request.post?
    #if request.post?
      usuario = Usuario.authenticate(params[:nombre], params[:clave])
      if usuario
        session[:usuario_id] = usuario.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })

      else
        flash[:error] = "Combinación invalida usuario/clave"
      end
    end
  end

  def logout
    session[:usuario_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index

  end

  def borrar_usuario
    if request.post?
      usuario = Usuario.find(params[:id])
      begin
        usuario.destroy
        flash[:notice] = "Usuario #{usuario.nombre} borrado"
      rescue Exception => e
        flash[:error] = e.message
      end
    end
    redirect_to(:action => :lista_usuarios)
  end

  def lista_usuarios
    @todos_usuarios = Usuario.find(:all)
  end

end

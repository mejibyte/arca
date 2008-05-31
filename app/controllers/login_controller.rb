class LoginController < ApplicationController
  def agregar_usuario
    @usuario = Usuario.new(params[:usuario])
    if request.post? and @usuario.save
      flash[:notice] = "Usuario #{@usuario.nombre} creado"
      @usuario = Usuario.new
    end
  end

  def login
    session[:usuario_id] = nil
    if request.post?
      usuario = Usuario.authenticate(params[:nombre], params[:clave])
      if usuario
        session[:usuario_id] = usuario.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })

      else
        flash[:notice] = "Combinación invalida usuario/clave"
      end
    end
  end
  
  def logout
  end

  def index
  end

  def borrar_usuario
  end

  def lista_usuarios
  end
end
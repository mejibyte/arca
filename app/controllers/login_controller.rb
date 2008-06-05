class LoginController < ApplicationController

  # Crea un nuevo usuario
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
  
  # Maneja el login en la aplicación
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
        redirect_to(uri || {:controller => "alumnos", :action => "index" })

      else
        flash[:error] = "Combinación invalida usuario/clave"
      end
    end
  end

  # Maneja la salida 'segura' de la aplicación
  def logout
    session[:usuario_id] = nil
    flash[:notice] = "Logged out"
    uri= session[:original_uri]
    redirect_to(uri ||{:action => "login"})
  end

  # No lo utilizamos
  def index

  end
  
  # Elimina un usuario
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

  # Indexa los usuarios
  def lista_usuarios
    @todos_usuarios = Usuario.find(:all)
  end

end

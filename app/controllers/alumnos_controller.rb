
class AlumnosController < ApplicationController
  # En lista los alumnos,
  # Además puede filtrar la lista por medio de la barra de busqueda
  def index
    @alumnos = Alumno.search((params[:buscar]))
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alumnos }
    end
  end

  # Mustra los datos del alumno
  def show
    @alumno = Alumno.find(params[:id])
    @grupo = Grupo.find(@alumno.grupo_id) unless @alumno.grupo_id.nil?
    @familia = Familia.find(@alumno.familia_id) unless @alumno.familia_id.nil?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alumno }
    end
  end

  # Define un alumno nuevo en la aplicación
  def new
    @alumno = Alumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alumno }
    end
  end

  # Edita los datos del alumno definido
  def edit
    @alumno = Alumno.find(params[:id])
  end

  # Crea un alumno en la aplicación
  def create
    @alumno = Alumno.new(params[:alumno])

    respond_to do |format|
      if @alumno.save
        flash[:notice] = "El alumno #{@alumno.nombre_completo} fue creado exitosamente"
        format.html { redirect_to(@alumno) }
        format.xml  { render :xml => @alumno, :status => :created, :location => @alumno }
      else
        flash[:error] = "Hubo un error creando el alumno"
        format.html { render :action => "new" }
        format.xml  { render :xml => @alumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza los datos del alumno
  def update
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      if @alumno.update_attributes(params[:alumno])
        flash[:notice] = "Los datos del alumno #{@alumno.nombre_completo} fueron actualizados"
        format.html { redirect_to(@alumno) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error actualizando el alumno"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina el alumno de la aplicación
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to(alumnos_url) }
      format.xml  { head :ok }
    end
  end
end

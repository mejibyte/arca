class GruposController < ApplicationController
  
  #Indexa los grupos
  def index
    @grupos = Grupo.search(params[:buscar])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grupos }
    end
  end

  # Muestra los detalles de un grupo
  def show
    @grupo = Grupo.find(params[:id])
    @profesor = @grupo.profesor
    @alumnos =  @grupo.alumnos

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grupo }
    end
  end

  # Determina un nuevo grupo
  def new
    @grupo = Grupo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grupo }
    end
  end

  # Edita el nombre y jornada de un grupo
  def edit
    @grupo = Grupo.find(params[:id])
  end

  # Crea un nuevo grupo en la aplicación
  def create
    @grupo = Grupo.new(params[:grupo])

    respond_to do |format|
      if @grupo.save
        flash[:notice] = "El Grupo #{@grupo.nombre} fue creado."
        format.html { redirect_to(@grupo) }
        format.xml  { render :xml => @grupo, :status => :created, :location => @grupo }
      else
        flash[:error] = "Hubo un error creando el grupo."
        format.html { render :action => "new" }
        format.xml  { render :xml => @grupo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza los datos del grupo
  def update
    @grupo = Grupo.find(params[:id])

    respond_to do |format|
      if @grupo.update_attributes(params[:grupo])
        flash[:notice] = "Los datos del Grupo #{@grupo.nombre} se han actualizado."
        format.html { redirect_to(@grupo) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error actualizando el grupo."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grupo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina un grupo
  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy

    respond_to do |format|
      format.html { redirect_to(grupos_url) }
      format.xml  { head :ok }
    end
  end

  # Quita el profesor del grupo
  def quitar_profesor
    @grupo = Grupo.find(params[:id])
    if request.put?
      @grupo.profesor = nil
      flash[:notice] = "Se quitó el profesor del grupo #{@grupo.nombre_completo}" if @grupo.save
      redirect_to grupo_path(@grupo)
    end
  end

  # Agrega un profesor al grupo, de los profesores disponibles, se pueden filtrar con la busqueda
  def agregar_profesor
    @grupo = Grupo.find(params[:id])
    if request.get?
      @profesores = Profesor.search(params[:buscar])
    end
    if request.put?
      @profesor = Profesor.find(params[:profesor_id])
      @grupo.profesor = @profesor
      flash[:notice] = "Se modificó el profesor al grupo #{@grupo.nombre_completo}" if @grupo.save
      redirect_to grupo_path(@grupo)
    end
  end

  # Agrega alumnos al grupo, que esten sin grupo, se pueden filtrar con la busqueda
  def agregar_alumnos
    @grupo = Grupo.find(params[:id])
    if request.get?
      @alumnos = Alumno.alumnos_sin_grupo(params[:buscar])
    end
    if request.put?
      unless params[:alumno_ids].nil?
        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @grupo.alumnos << a
        end
        flash[:notice] = "Se agregaron los alumnos al grupo" if @grupo.save
      end
      redirect_to grupo_path(@grupo)
    end
  end

  # Quita los alumnos seleccionados del grupo
  def quitar_alumnos
    @grupo = Grupo.find(params[:id])
    if request.get?
      @alumnos = @grupo.alumnos
    end
    if request.put?
      unless params[:alumno_ids].nil?
        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @grupo.alumnos.delete(a)
        end
        flash[:notice] = "Se quitaron los alumnos del grupo" if @grupo.save
      end
      redirect_to grupo_path(@grupo)
    end
  end
end


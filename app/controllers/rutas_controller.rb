class RutasController < ApplicationController
  before_filter :load_transportador
  
  # Carga los datos del transportador
  def load_transportador
    @transportador = Transportador.find(params[:transportador_id]) unless params[:transportador_id].nil?
  end
  
  #Indexa las rutas
  def index
    @rutas = Ruta.find(:all,:order => "sector ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rutas }
    end
  end

  # Muestra todos los detalles de la ruta
  def show

    @ruta = @transportador.ruta if @transportador
    @ruta ||= Ruta.find(params[:id])
    @alumnos = @ruta.alumnos

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ruta }
    end
  end

  # Crea una nueva ruta
  def new
    if @transportador.nil?
      flash[:error] = "Escoja un transportador y añada la ruta"
      redirect_to transportadors_path
    else
      @ruta = Ruta.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @ruta }
      end
    end
  end

  # Edita los datos de la ruta
  def edit
    @ruta = @transportador.ruta if @transportador
    @ruta ||= Ruta.find(params[:id])
    @transportador ||= @ruta.transportador
  end

  # Crea una nueva ruta
  def create
    @ruta = Ruta.new(params[:ruta])
    @ruta.transportador = @transportador

    respond_to do |format|
      if @ruta.save && @transportador.save
        flash[:notice] = "La ruta se creo exitosamente."
        format.html { redirect_to transportador_path(@transportador) }
        format.xml  { render :xml => @ruta, :status => :created, :location => @ruta }
      else
        flash[:error] = "Hubo un error al crear la ruta."
        format.html { render :action => "new" }
        format.xml  { render :xml => @ruta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza la información respectiva a una ruta
  def update
    @ruta = Ruta.find(params[:id])

    respond_to do |format|
      if @ruta.update_attributes(params[:ruta])
        flash[:notice] = "La ruta se actualizó exitosamente."
        format.html { redirect_to transportador_path(@transportador) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error al editar la ruta."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ruta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina la ruta especificada
  def destroy
    @ruta = @transportador.ruta
    @ruta.destroy

    respond_to do |format|
      format.html { redirect_to transportador_path(@transportador) }
      format.xml  { head :ok }
    end
  end

  # Busca los alumno sin ruta, los indexa, para poderlos escoger y agregar a la ruta
  def agregar_alumnos
    @ruta = Ruta.find(params[:id])
    if request.get?
      @alumnos = Alumno.find :all, :conditions => { :ruta_id => nil}, :order => "apellidos, nombres ASC"
      @alumnos.delete_if { |a| a.exalumno }
    end
    if request.put?
      unless params[:alumno_ids].nil?
        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @ruta.alumnos << a
        end
        flash[:notice] = "Se agregaron los alumnos a la ruta" if @ruta.save
      end
      redirect_to ruta_path(@ruta)
    end
  end

  # Elimina los alumnos seleccionados de la ruta
  def quitar_alumnos
    @ruta = Ruta.find(params[:id])
    if request.get?
      @alumnos = @ruta.alumnos
    end
    if request.put?
      unless params[:alumno_ids].nil?
        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @ruta.alumnos.delete(a)
        end
        flash[:notice] = "Se quitaron los alumnos de la ruta" if @ruta.save
      end
      redirect_to ruta_path(@ruta)
    end
  end

end

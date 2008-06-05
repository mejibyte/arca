class FaltaDeAsistenciasController < ApplicationController
  before_filter :load_alumno

  # Carga los datos del o de los alumnos con faltas de asistencias
  def load_alumno
    @alumno = Persona.find(params[:alumno_id], :conditions => { :type => "Alumno"}) unless params[:alumno_id].nil?
  end

  # En lista las faltas de asistencias de un alumno en particular
  # Se puden filtrar por medio de la barra de busqueda
  def index
    if params[:alumno_id].nil?
      redirect_to index_all_falta_de_asistencias_path
    else

      @falta_de_asistencias = FaltaDeAsistencia.search(@alumno,params[:antes],params[:despues])
      if @falta_de_asistencias.nil?
        unless (params[:antes].nil? or params[:antes].blank?) and (params[:despues].nil? or params[:despues].blank?)
          flash[:error] = "Fechas inválidas. Asegúrese de haber ingresado dos fechas en formato AAAA-MM-DD y de sean fechas válidas (Por ejemplo 30 de Febrero no es una fecha válida)"
        end
        @falta_de_asistencias = @alumno.falta_de_asistencias.find :all, :order => "fecha ASC"
      end
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @falta_de_asistencias }
      end
    end
  end

  # Muestra los detalles de la falta de asistencia
  def show
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @falta_de_asistencia }
    end
  end

  # Determina una falta de asistencia para determinado alumno
  def new
    @falta_de_asistencia = @alumno.falta_de_asistencias.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @falta_de_asistencia }
    end
  end

  # Edita los datos de la faltas de asistencia de determinado alumno
  def edit
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])
  end

  
  # Agrega una nueva falta de asistencia a un alumno en particular
  def create
    @falta_de_asistencia = @alumno.falta_de_asistencias.build(params[:falta_de_asistencia])

    respond_to do |format|
      if @falta_de_asistencia.save
        flash[:notice] = "Se ha agregado correctamente la falta de asistencia al alumno #{@alumno.nombre_completo}."
        format.html { redirect_to([@alumno, @falta_de_asistencia]) }
        format.xml  { render :xml => @falta_de_asistencia, :status => :created, :location => @falta_de_asistencia }
      else
        flash[:error] = "Hubo un error agregando la falta de asistencia"
        format.html { render :action => "new" }
        format.xml  { render :xml => @falta_de_asistencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza los datos de la falta de asistencia
  def update
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])

    respond_to do |format|
      if @falta_de_asistencia.update_attributes(params[:falta_de_asistencia])
        flash[:notice] = "Los datos de la falta de asistencia de #{@alumno.nombre_completo} se han actualizado."
        format.html { redirect_to([@alumno, @falta_de_asistencia]) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error editando la falta de asistencia"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @falta_de_asistencia.errors, :status => :unprocessable_entity }
      end
    end
  end
  # Elimina una falta de asistencia determinada
  def destroy
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])
    @falta_de_asistencia.destroy

    respond_to do |format|
      format.html { redirect_to(alumno_falta_de_asistencias_url(@alumno)) }
      format.xml  { head :ok }
    end
  end

  # Despliega todas las faltas de asistencia
  # Se pueden filtrar por fechas con las barras de busqueda
  def index_all
    @falta_de_asistencias = FaltaDeAsistencia.searchAll(params[:antes],params[:despues])
    if @falta_de_asistencias.nil?
      unless (params[:antes].nil? or params[:antes].blank?) and (params[:despues].nil? or params[:despues].blank?)
        flash[:error] = "Fechas inválidas. Asegúrese de haber ingresado dos fechas en formato AAAA-MM-DD y de sean fechas válidas (Por ejemplo 30 de Febrero no es una fecha válida)"
      end
      @falta_de_asistencias = FaltaDeAsistencia.find :all, :order => "fecha ASC"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @falta_de_asistencias }
    end
  end

end

class ExalumnosController < ApplicationController
  before_filter :load_alumno
  # Carga los datos del alumno
  def load_alumno
    @alumno = Persona.find(params[:alumno_id], :conditions => { :type => "Alumno"})  unless params[:alumno_id].nil?
   # @alumno = Persona.search(, @params[:buscar])  unless params[:alumno_id].nil?
   # @alumno = Alumno.searchEx(params[:alumno_id],params[:buscar])unless params[:alumno_id].nil?
  end

  # Lista los exalumnos
  def index
    @exalumnos = Exalumno.find :all
    # @exalumnos = Exalumno.searchEx(@alumno,params[:buscar])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exalumnos }
    end
  end

  # Muestra los datos de determinado alumno
  def show
    @exalumno = @alumno.exalumno

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # Determina un nuevo alumno en la aplicación
  def new
    @exalumno = Exalumno.new(:persona_id => @alumno.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # Edita los datos del exalumno
  def edit
    @exalumno = @alumno.exalumno
  end

  # Crea un nuevo exalumno en la aplicación
  def create
    @exalumno = Exalumno.new(params[:exalumno])
    @exalumno.alumno = @alumno
    @alumno.grupo = nil # Al graduarlo, el niño sale de su grupo

    respond_to do |format|
      if @exalumno.save && @alumno.save
        flash[:notice] = "El alumno #{@exalumno.alumno.nombre_completo} fue correctamente marcado como un exalumno."
        format.html { redirect_to(@alumno) }
        format.xml  { render :xml => @exalumno, :status => :created, :location => @exalumno }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza los datos del exalumno
  def update
    @exalumno = @alumno.exalumno

    respond_to do |format|
      if @exalumno.update_attributes(params[:exalumno])
        flash[:notice] = "Los datos del exalumno #{@exalumno.alumno.nombre_completo} se han actualizado."
        format.html { redirect_to(@alumno) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end


  # Elimina el estado exalumno de un alumno
  def destroy
    @exalumno = @alumno.exalumno
    @exalumno.destroy

    respond_to do |format|
      format.html { redirect_to(alumno_path(@alumno)) }
      format.xml  { head :ok }
    end
  end

end

class ExalumnosController < ApplicationController
  before_filter :load_alumno

  def load_alumno
    @alumno = Persona.find(params[:alumno_id], :conditions => { :type => "Alumno"})  unless params[:alumno_id].nil?
  end

  # GET /exalumnos
  # GET /exalumnos.xml
  def index
    @exalumnos = Exalumno.find :all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exalumnos }
    end
  end

  # GET /exalumnos/1
  # GET /exalumnos/1.xml
  def show
    @exalumno = @alumno.exalumno

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # GET /exalumnos/new
  # GET /exalumnos/new.xml
  def new
    @exalumno = Exalumno.new
    @exalumno.alumno = @alumno

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # GET /exalumnos/1/edit
  def edit
    @exalumno = @alumno.exalumno
  end

  # POST /exalumnos
  # POST /exalumnos.xml
  def create
    @exalumno = Exalumno.new(params[:exalumno])
    @exalumno.alumno = @alumno

    respond_to do |format|
      if @exalumno.save
        flash[:notice] = 'El alumno #{@exalumno.alumno.nombre_completo} fue correctamente retirado.'
        format.html { redirect_to([@alumno, @exalumno]) }
        format.xml  { render :xml => @exalumno, :status => :created, :location => @exalumno }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exalumnos/1
  # PUT /exalumnos/1.xml
  def update
    @exalumno = @alumno.exalumno

    respond_to do |format|
      if @exalumno.update_attributes(params[:exalumno])
        flash[:notice] = 'Los datos del exalumno #{@exalumno.alumno.nombre_completo} se han actualizado.'
        format.html { redirect_to([@alumno, @exalumno]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /exalumnos/1
  # DELETE /exalumnos/1.xml
  def destroy
    @exalumno = @alumno.exalumno
    @exalumno.destroy

    respond_to do |format|
      format.html { redirect_to(alumno_exalumnos_url(@alumno)) }
      format.xml  { head :ok }
    end
  end

end

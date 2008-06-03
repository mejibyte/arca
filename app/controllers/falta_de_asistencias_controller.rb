class FaltaDeAsistenciasController < ApplicationController
  before_filter :load_alumno
  def load_alumno
    @alumno = Persona.find(params[:alumno_id], :conditions => { :type => "Alumno"}) unless params[:alumno_id].nil?
  end

  # GET /falta_de_asistencias
  # GET /falta_de_asistencias.xml
  def index
    if params[:alumno_id].nil?
      redirect_to index_all_falta_de_asistencias_path
    else
      @falta_de_asistencias = @alumno.falta_de_asistencias.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @falta_de_asistencias }
      end
    end
  end

  # GET /falta_de_asistencias/1
  # GET /falta_de_asistencias/1.xml
  def show
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @falta_de_asistencia }
    end
  end

  # GET /falta_de_asistencias/new
  # GET /falta_de_asistencias/new.xml
  def new
    @falta_de_asistencia = @alumno.falta_de_asistencias.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @falta_de_asistencia }
    end
  end

  # GET /falta_de_asistencias/1/edit
  def edit
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])
  end

  # POST /falta_de_asistencias
  # POST /falta_de_asistencias.xml
  def create
    @falta_de_asistencia = @alumno.falta_de_asistencias.build(params[:falta_de_asistencia])

    respond_to do |format|
      if @falta_de_asistencia.save
        flash[:notice] = 'FaltaDeAsistencia was successfully created.'
        format.html { redirect_to([@alumno, @falta_de_asistencia]) }
        format.xml  { render :xml => @falta_de_asistencia, :status => :created, :location => @falta_de_asistencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @falta_de_asistencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /falta_de_asistencias/1
  # PUT /falta_de_asistencias/1.xml
  def update
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])

    respond_to do |format|
      if @falta_de_asistencia.update_attributes(params[:falta_de_asistencia])
        flash[:notice] = 'FaltaDeAsistencia was successfully updated.'
        format.html { redirect_to([@alumno, @falta_de_asistencia]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @falta_de_asistencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /falta_de_asistencias/1
  # DELETE /falta_de_asistencias/1.xml
  def destroy
    @falta_de_asistencia = @alumno.falta_de_asistencias.find(params[:id])
    @falta_de_asistencia.destroy

    respond_to do |format|
      format.html { redirect_to(alumno_falta_de_asistencias_url(@alumno)) }
      format.xml  { head :ok }
    end
  end

  def index_all
    @falta_de_asistencias = FaltaDeAsistencia.find :all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @falta_de_asistencias }
    end
  end

end

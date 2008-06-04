class AlumnosController < ApplicationController
  # GET /alumnos
  # GET /alumnos.xml
  def index
    @alumnos = Alumno.search((params[:buscar]))
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alumnos }
    end
  end

  # GET /alumnos/1
  # GET /alumnos/1.xml
  def show
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alumno }
    end
  end

  # GET /alumnos/new
  # GET /alumnos/new.xml
  def new
    @alumno = Alumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
  end

  # POST /alumnos
  # POST /alumnos.xml
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

  # PUT /alumnos/1
  # PUT /alumnos/1.xml
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

  # DELETE /alumnos/1
  # DELETE /alumnos/1.xml
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to(alumnos_url) }
      format.xml  { head :ok }
    end
  end
end

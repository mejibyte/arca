class FamiliasController < ApplicationController
  # GET /familias
  # GET /familias.xml
  def index
    @familias = Familia.search(params[:buscar])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @familias }
    end
  end

  # GET /familias/1
  # GET /familias/1.xml
  def show
    @familia = Familia.find(params[:id])
    @personas = @familia.personas_no_alumno
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @familia }
    end
  end

  # GET /familias/new
  # GET /familias/new.xml
  def new
    @familia = Familia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @familia }
    end
  end

  # GET /familias/1/edit
  def edit
    @familia = Familia.find(params[:id])
  end

  # POST /familias
  # POST /familias.xml
  def create
    @familia = Familia.new(params[:familia])

    respond_to do |format|
      if @familia.save
        flash[:notice] = "La Familia #{@familia.nombre} fue creada exitosamente."
        format.html { redirect_to(@familia) }
        format.xml  { render :xml => @familia, :status => :created, :location => @familia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @familia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /familias/1
  # PUT /familias/1.xml
  def update
    @familia = Familia.find(params[:id])

    respond_to do |format|
      if @familia.update_attributes(params[:familia])
        flash[:notice] = "Los datos de la Familia #{@familia.nombre} se han actualizado."
        format.html { redirect_to(@familia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @familia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /familias/1
  # DELETE /familias/1.xml
  def destroy
    @familia = Familia.find(params[:id])
    @familia.destroy

    respond_to do |format|
      format.html { redirect_to(familias_url) }
      format.xml  { head :ok }
    end
  end

  def agregar_alumnos
    if request.get?
      @familia = Familia.find(params[:id])
      @alumnos = Alumno.alumnos_sin_familia(params[:buscar])
    end

    if request.put?
      @familia = Familia.find(params[:familia_id])
      unless params[:alumno_ids].nil?

        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @familia.alumnos << a
        end
        flash[:notice] = "Se agregaron los alumnos a la familia" if @familia.save
      end
      redirect_to familia_path(@familia.id)
    end
  end

    def quitar_alumnos
    if request.get?
      @familia = Familia.find(params[:id])
      @alumnos = @familia.alumnos
    end

    if request.put?
      @familia = Familia.find(params[:familia_id])
      unless params[:alumno_ids].nil?
        @alumnos = Alumno.find(params[:alumno_ids])
        for a in @alumnos
          @familia.alumnos.delete(a)
        end
        flash[:notice] = "Se quitaron los alumnos de la familia" if @familia.save
      end
      redirect_to familia_path(@familia.id)
    end
  end

  def agregar_personas
    if request.get?
      @familia = Familia.find(params[:id])
      @personas = Persona.personas_sin_familia(params[:buscar])
    end

    if request.put?
      @familia = Familia.find(params[:familia_id])
      unless params[:persona_ids].nil?

        @personas = Persona.find(params[:persona_ids])
        for p in @personas
          @familia.personas << p
        end
        flash[:notice] = "Se agregaron las personas a la familia" if @familia.save
      end
      redirect_to familia_path(@familia.id)
    end
  end

    def quitar_personas
    if request.get?
      @familia = Familia.find(params[:id])
      @personas = Persona.find(:all, :conditions => {:type => nil, :familia_id => @familia.id } )
    end

    if request.put?
      @familia = Familia.find(params[:familia_id])
      unless params[:persona_ids].nil?
        @personas = Persona.find(params[:persona_ids])
        for p in @personas
          @familia.personas.delete(p)
        end
        flash[:notice] = "Se quitaron las personas de la familia" if @familia.save
      end
      redirect_to familia_path(@familia.id)
    end
  end


end

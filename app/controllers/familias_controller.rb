class FamiliasController < ApplicationController
  # Indexa el nombre de todas las familias
  def index
    @familias = Familia.search(params[:buscar])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @familias }
    end
  end
  # Muestra los detalles de la familia
  def show
    @familia = Familia.find(params[:id])
    @personas = @familia.personas_no_alumno
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @familia }
    end
  end

  # Determina una nueva familia
  def new
    @familia = Familia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @familia }
    end
  end
  
  # Edita el nombre de una familia
  def edit
    @familia = Familia.find(params[:id])
  end

  # Crea una nueva familia en la aplicación
  def create
    @familia = Familia.new(params[:familia])

    respond_to do |format|
      if @familia.save
        flash[:notice] = "La Familia #{@familia.nombre} fue creada exitosamente."
        format.html { redirect_to(@familia) }
        format.xml  { render :xml => @familia, :status => :created, :location => @familia }
      else
        flash[:error] = "Hubo un error creando la familia."
        format.html { render :action => "new" }
        format.xml  { render :xml => @familia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza la informacion de la familia
  def update
    @familia = Familia.find(params[:id])

    respond_to do |format|
      if @familia.update_attributes(params[:familia])
        flash[:notice] = "Los datos de la Familia #{@familia.nombre} se han actualizado."
        format.html { redirect_to(@familia) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error actualizando la familia."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @familia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina una familia
  def destroy
    @familia = Familia.find(params[:id])
    @familia.destroy

    respond_to do |format|
      format.html { redirect_to(familias_url) }
      format.xml  { head :ok }
    end
  end
  
  # Agrega niño/alumnos a la familia determinada
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

  # Quita los niños/alumnos de la familia
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

  # Agrega las personas/familiares de un o varios niño en una familia
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
  
  # Quita personas/familiares de una familia
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

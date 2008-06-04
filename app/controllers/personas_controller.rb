class PersonasController < ApplicationController

  def index
    #Muestra únicamente las personas "puras",
    #no las heredadas, por eso el :type => nil
    @personas = Persona.search((params[:buscar]))
    respond_to do |format|
      format.html
      format.xml { render :xml => @personas }
    end
  end

  # GET /personas/1
  # GET /personas/1.xml
  def show
    @persona = Persona.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alumno }
    end
  end

  def new
    @persona = Persona.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    @persona = Persona.find(params[:id])
  end


  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        flash[:notice] = "La Persona #{@persona.nombre_completo} fue creado correctamente."
        format.html { redirect_to(personas_path) }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end

  end

  # PUT /personas/1
  # PUT /personas/1.xml
  def update
    @persona = Persona.find(params[:id])

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        flash[:notice] = "Los datos de la Persona #{@persona.nombre_completo} fueron actualizados correctamente."
        format.html { redirect_to(@persona) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.xml
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end
end

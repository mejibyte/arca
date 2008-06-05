class PersonasController < ApplicationController

  #Muestra únicamente las personas "puras",
  #no las heredadas, por eso el :type => nil
  def index
    @personas = Persona.search((params[:buscar]))
    respond_to do |format|
      format.html
      format.xml { render :xml => @personas }
    end
  end

  # Muestra los detalles de la persona
  def show
    @persona = Persona.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alumno }
    end
  end
  
  # Define una nueva persona en la aplicación
  def new
    @persona = Persona.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @persona }
    end
  end

  # Edita los datos de la persona
  def edit
    @persona = Persona.find(params[:id])
  end

  # Crea una nueva persona
  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        flash[:notice] = "La Persona #{@persona.nombre_completo} fue creado correctamente."
        format.html { redirect_to(personas_path) }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        flash[:error] = "Hubo un error creando la persona."
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end

  end

  # Actualiza los datos de la persona
  def update
    @persona = Persona.find(params[:id])

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        flash[:notice] = "Los datos de la Persona #{@persona.nombre_completo} fueron actualizados correctamente."
        format.html { redirect_to(@persona) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error editando la persona."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina una persona
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end
end

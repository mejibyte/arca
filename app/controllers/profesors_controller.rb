class ProfesorsController < ApplicationController

  #Indexa los profesores, se pueden filtrar por nombre y apellidos
  def index
    @profesors = Profesor.search(params[:buscar])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profesors }
    end
  end

  # Muestra los detalles del profesor
  def show
    @profesor = Profesor.find(params[:id])
    @grupos = Grupo.find_all_by_profesor_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profesor }
    end
  end

  # Determina un nuevo profesor
  def new
    @profesor = Profesor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profesor }
    end
  end

  # Edita la informacion del profesor
  def edit
    @profesor = Profesor.find(params[:id])
  end

  # Crea un nuevo profesor
  def create
    @profesor = Profesor.new(params[:profesor])

    respond_to do |format|
      if @profesor.save
        flash[:notice] = " El Profesor #{@profesor.nombre_completo} fue creado exitosamente."
        format.html { redirect_to(@profesor) }
        format.xml  { render :xml => @profesor, :status => :created, :location => @profesor }
      else
        flash[:error] = "Hubo un error creando el profesor."
        format.html { render :action => "new" }
        format.xml  { render :xml => @profesor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza los datos del profesor
  def update
    @profesor = Profesor.find(params[:id])

    respond_to do |format|
      if @profesor.update_attributes(params[:profesor])
        flash[:notice] = "Los datos del Profesor #{@profesor.nombre_completo} se han actualizado."
        format.html { redirect_to(@profesor) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error editando el profesor."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profesor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina los datos del profesor
  def destroy
    @profesor = Profesor.find(params[:id])
    @profesor.destroy

    respond_to do |format|
      format.html { redirect_to(profesors_url) }
      format.xml  { head :ok }
    end
  end
end

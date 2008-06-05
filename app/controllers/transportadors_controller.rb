class TransportadorsController < ApplicationController


  # Indexa los transportadores
  def index
    @transportadors = Transportador.find(:all, :order => "apellidos, nombres ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transportadors }
    end
  end

  # Muestra la información de la persona
  def show
    @transportador = Transportador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transportador }
    end
  end

  # Determina la informacion del nuevo transportador
  def new
    @transportador = Transportador.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transportador }
    end
  end

  # Edita los datos del transportador
  def edit
    @transportador = Transportador.find(params[:id])
  end

  # Crea el nuevo transportador
  def create
    @transportador = Transportador.new(params[:transportador])

    respond_to do |format|
      if @transportador.save
        flash[:notice] = "El transportador #{@transportador.nombre_completo} fue creado exitosamente."
        format.html { redirect_to(@transportador) }
        format.xml  { render :xml => @transportador, :status => :created, :location => @transportador }
      else
        flash[:error] = "Hubo un error creando el transportador."
        format.html { render :action => "new" }
        format.xml  { render :xml => @transportador.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza la información del transportador  
  def update
    @transportador = Transportador.find(params[:id])

    respond_to do |format|
      if @transportador.update_attributes(params[:transportador])
        flash[:notice] = "Los datos del transportador #{@transportador.nombre_completo} se han actualizado."
        format.html { redirect_to(@transportador) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        flash[:error] = "Hubo un error editando el transportador."
        format.xml  { render :xml => @transportador.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina el transportador
  def destroy
    @transportador = Transportador.find(params[:id])
    @transportador.destroy

    respond_to do |format|
      format.html { redirect_to(transportadors_url) }
      format.xml  { head :ok }
    end
  end
end

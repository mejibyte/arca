class RutasController < ApplicationController
  before_filter :load_transportador

  def load_transportador
    @transportador = Transportador.find(params[:transportador_id]) unless params[:transportador_id].nil?
  end
  # GET /rutas
  # GET /rutas.xml
  def index
    @rutas = Ruta.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rutas }
    end
  end

  # GET /rutas/1
  # GET /rutas/1.xml
  def show

    @ruta = @transportador.ruta if @transportador
    @ruta ||= Ruta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ruta }
    end
  end

  # GET /rutas/new
  # GET /rutas/new.xml
  def new
    if @transportador.nil?
      flash[:error] = "Escoja un transportador y añada la ruta"
      redirect_to transportadors_path
    else
      @ruta = Ruta.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @ruta }
      end
    end
  end

  # GET /rutas/1/edit
  def edit
    @ruta = @transportador.ruta if @transportador
    @ruta ||= Ruta.find(params[:id])
    @transportador ||= @ruta.transportador
  end

  # POST /rutas
  # POST /rutas.xml
  def create
    @ruta = Ruta.new(params[:ruta])
    @ruta.transportador = @transportador

    respond_to do |format|
      if @ruta.save && @transportador.save
        flash[:notice] = "La ruta se creo exitosamente."
        format.html { redirect_to transportador_path(@transportador) }
        format.xml  { render :xml => @ruta, :status => :created, :location => @ruta }
      else
        flash[:error] = "Hubo un error al crear la ruta."
        format.html { render :action => "new" }
        format.xml  { render :xml => @ruta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rutas/1
  # PUT /rutas/1.xml
  def update
    @ruta = Ruta.find(params[:id])

    respond_to do |format|
      if @ruta.update_attributes(params[:ruta])
        flash[:notice] = "La ruta se actualizó exitosamente."
        format.html { redirect_to transportador_path(@transportador) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error al editar la ruta."
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ruta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rutas/1
  # DELETE /rutas/1.xml
  def destroy
    @ruta = @transportador.ruta
    @ruta.destroy

    respond_to do |format|
      format.html { redirect_to transportador_path(@transportador) }
      format.xml  { head :ok }
    end
  end
end

class TelefonosController < ApplicationController
  before_filter :load_persona

  def load_persona
    if params[:persona_id].nil?
      redirect_to personas_path
    else
      @persona = Persona.find(params[:persona_id])
    end
  end

  # GET /telefonos
  # GET /telefonos.xml
  def index
    @telefonos = @persona.telefonos.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @telefonos }
    end
  end

  # GET /telefonos/1
  # GET /telefonos/1.xml
  def show
    @telefono = @persona.telefonos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @telefono }
    end
  end

  # GET /telefonos/new
  # GET /telefonos/new.xml
  def new
    @telefono = @persona.telefonos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @telefono }
    end
  end

  # GET /telefonos/1/edit
  def edit
    @telefono = @persona.telefonos.find(params[:id])
  end

  # POST /telefonos
  # POST /telefonos.xml
  def create
    @telefono = @persona.telefonos.build(params[:telefono])

    respond_to do |format|
      if @telefono.save
        flash[:notice] = 'Telefono was successfully created.'
        format.html { redirect_to([@persona, @telefono]) }
        format.xml  { render :xml => @telefono, :status => :created, :location => @telefono }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @telefono.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /telefonos/1
  # PUT /telefonos/1.xml
  def update
    @telefono = @persona.telefonos.find(params[:id])

    respond_to do |format|
      if @telefono.update_attributes(params[:telefono])
        flash[:notice] = 'Telefono was successfully updated.'
        format.html { redirect_to([@persona, @telefono]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @telefono.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /telefonos/1
  # DELETE /telefonos/1.xml
  def destroy
    @telefono = @persona.telefonos.find(params[:id])
    @telefono.destroy

    respond_to do |format|
      format.html { redirect_to(persona_telefonos_url(@persona)) }
      format.xml  { head :ok }
    end
  end
end

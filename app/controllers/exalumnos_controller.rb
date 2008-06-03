class ExalumnosController < ApplicationController
  # GET /exalumnos
  # GET /exalumnos.xml
  def index
    @exalumnos = Exalumno.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exalumnos }
    end
  end

  # GET /exalumnos/1
  # GET /exalumnos/1.xml
  def show
    @exalumno = Exalumno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # GET /exalumnos/new
  # GET /exalumnos/new.xml
  def new
    @exalumno = Exalumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exalumno }
    end
  end

  # GET /exalumnos/1/edit
  def edit
    @exalumno = Exalumno.find(params[:id])
  end

  # POST /exalumnos
  # POST /exalumnos.xml
  def create
    @exalumno = Exalumno.new(params[:exalumno])

    respond_to do |format|
      if @exalumno.save
        flash[:notice] = 'Exalumno was successfully created.'
        format.html { redirect_to(@exalumno) }
        format.xml  { render :xml => @exalumno, :status => :created, :location => @exalumno }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exalumnos/1
  # PUT /exalumnos/1.xml
  def update
    @exalumno = Exalumno.find(params[:id])

    respond_to do |format|
      if @exalumno.update_attributes(params[:exalumno])
        flash[:notice] = 'Exalumno was successfully updated.'
        format.html { redirect_to(@exalumno) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exalumno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exalumnos/1
  # DELETE /exalumnos/1.xml
  def destroy
    @exalumno = Exalumno.find(params[:id])
    @exalumno.destroy

    respond_to do |format|
      format.html { redirect_to(exalumnos_url) }
      format.xml  { head :ok }
    end
  end

end

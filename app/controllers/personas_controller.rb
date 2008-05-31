class PersonasController < ApplicationController

  def index
    #Muestra únicamente las personas "puras",
    #no las heredadas, por eso el :type => nil
    @personas = Persona.find(:all, :conditions => { :type => nil } )

    respond_to do |format|
      format.html
      format.xml { render :xml => @personas }
    end
  end

  def new
    @persona = Persona.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @persona }
    end
  end

  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        flash[:notice] = 'Persona was successfully created.'
        format.html { redirect_to(personas_path) }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end

  end
end

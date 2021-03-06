class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    
    #session management
   if params[:search]

     redirect=false

     if params[:category]
        @category=params[:category]
        session[:category]=params[:category]

     elsif session[:category]&&session[:category].length != 0
        @category=session[:category]
        redirect=true

     else
        @category=nil

     end
 
     if params[:semester]
        @semester=params[:semester]
        session[:semester]=params[:semester]
    
     elsif session[:semester]&&session[:semester].length !=0
        @semester=session[:semester]
        redirect=true

     else 
        @semester=nil

     end
    
     if params[:year]
     
        @year=params[:year]
        session[:year]=params[:year]

     elsif session[:year]&&session[:year].length !=0
        @year=session[:year]
        redirect=true

     else 
        @year=nil

     end

     if redirect
               redirect_to events_path(:category =>@category, :semester => @semester,:year =>@year,:search => params[:search])
     end
    
    #filter
     if @category && @semester && @year
              @events = Event.where(:category =>@category, :semester => @semester,:year =>@year) 

     elsif  @category && @semester
              @events = Event.where(:category =>@category, :semester => @semester)
              
     elsif  @category && @year
              @events = Event.where(:category =>@category,:year =>@year) 
              
     elsif @semester && @year
              @events = Event.where(:semester => @semester,:year =>@year)     
          
     elsif @category
              @events = Event.where(:category =>@category)
              
     elsif @semester
              @events = Event.where(:semester => @semester)

     elsif @year
              @events =Event.where(:year =>@year)
                
     else
              @events = Event.all

     end

   else
    
      @events = Event.all
      session[:category]=nil
      session[:semester]=nil
      session[:year]=nil

   end

  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :year, :semester, :category, :description)
    end
end

class DriversController < ApplicationController
  before_action :set_driver, only: %i[show edit update destroy]

  # GET /drivers
  # GET /drivers.json
  def index
    @DriverArray = []
    @DriversList=[]
    @driver_hash=Hash.new()
    @drivers = Driver.all
    @SourceLatitude=31.2555
    @SourceLogitude=29.9832
  
    @hash = Gmaps4rails.build_markers(@drivers) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      # put all driver in array to loop on them
      @Loc=Geocoder::Calculations.distance_between([@SourceLatitude,@SourceLogitude], [user.latitude, user.longitude])
      if !@Loc.nan?  then 
       @DriverArray << @Loc
       @driver_hash[@Loc]=user
      end
      # end of driver array   
    end

    #Shortest Route To Source
    @SortedDriversArray=@DriverArray.sort

    @NearestDriverLocation=@SortedDriversArray[0]

    @NearestDriver=@driver_hash[@NearestDriverLocation]
    # End of Short Route Finding 

    #Final Sorted Drivers Obj
    @SortedDriversArray.each do |driverloc|
      @DriverObject=@driver_hash[driverloc]
      @DriverLocation=driverloc
      @DriversList.push(@DriverObject)
    end
    #End of SOrted Dirvers Obj
     
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    @dirver = Driver.find(params[:id])
    
    @hash = Gmaps4rails.build_markers(@drivers) do |user, marker|
      # if (user.latitude!="") && (user.longitude!="") then
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.name
      @distance = Geocoder::Calculations.distance_between([31.2555, 29.9832], [user.latitude, user.longitude])
      # else
        # user.latitude=1
        # user.longitude=1
        
        # marker.lat user.latitude
        # marker.lng user.longitude
        # @distance = Geocoder::Calculations.distance_between([31.2555, 29.9832], [user.latitude, user.longitude])

      # end
    end
   
  end

  # GET /drivers/new
  def new
    @driver = Driver.new
  end

  # GET /drivers/1/edit
  def edit; end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(driver_params)

    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    respond_to do |format|
      if @driver.update(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to drivers_url, notice: 'Driver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_driver
    @driver = Driver.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def driver_params
    params.require(:driver).permit(:latitude, :longitude, :address, :name, :age, :phone, :email)
  end
end
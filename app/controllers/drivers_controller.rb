class DriversController < ApplicationController
    before_action :check_duplication , only: :create

   def create
    @driver=Driver.new(driver_params)
    @driver.save
    render json: @driver
   end
   
   
    def self.locations(srcLTD,srcLGT)
        @Drivers_distances_array = []
        @DriversList=[]
        @driver_hash=Hash.new()
        @drivers = Driver.all
        @SourceLatitude=srcLTD
        @SourceLogitude=srcLGT
      
        @hash = Gmaps4rails.build_markers(@drivers) do |driver, marker|
          marker.lat driver.latitude
          marker.lng driver.longitude
          # put all driver in array to loop on them
          @Distance=Geocoder::Calculations.distance_between([@SourceLatitude,@SourceLogitude], [driver.latitude, driver.longitude])
          if !@Distance.nan?  then 
            @Drivers_distances_array << @Distance
           @driver_hash[@Distance]=driver
          end
          # end of driver array   
        end
    
        #Shortest Route To Source
        @Sorted_Drivers_Distances_Array=@Drivers_distances_array.sort
    
        @Nearest_Driver_Location=@Sorted_Drivers_Distances_Array[0]
    
        @NearestDriver=@driver_hash[@Nearest_Driver_Location]
        # End of Short Route Finding 
    
        #Final Sorted Drivers Obj
          @Sorted_Drivers_Distances_Array.each do |driverloc|
          @DriverObject=@driver_hash[driverloc]
          # @DriverLocation=driverloc
          @DriversList.push(@DriverObject)
        end
        #End of SOrted Dirvers Obj

        data={"nn": @NearestDriver,"Distances": @Sorted_Drivers_Distances_Array ,"Drivers_List": @DriversList }
        render json: data
         
      end


      def check_duplication
        if Driver.find_by_email(driver_params[:email])
            @response = {message: "Email Already Exists"}
            render json: @response      
        elsif Driver.find_by_phone(driver_params[:phone])
            @response = {message: "Phone Already Exists"}
            render json: @response
            
        end
      end

      def driver_params
        params.permit(:name,:phone,:email,:latitude,:longitude)
      end
end

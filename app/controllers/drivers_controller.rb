class DriversController < ApplicationController
    require 'json'
    before_action :authorize_request ,:is_logged_in
    before_action :check_duplication , only: :create
    skip_before_action :authorize_request, only: :create
    skip_before_action :is_logged_in, only: :create 

    def authorize_request
      @current_driver = (AuthorizeApiRequest.new(request.headers).call)[:driver]
    end

    def is_logged_in
      if !((AuthorizeApiRequest.new(request.headers).call)[:driver].status=='online')
         json_response({message: Message.driver_is_offline} )
      end
    end
   

    def show 
      orders=Order.where("status = :status AND driver_id = :driver ",
        {status: 3, driver: current_driver.id})
        # no 3 in status mean history as it is placed in order model
      response={ message: Message.success ,orders: orders  }
      json_response(response)
  end

   def create
    @driver=Driver.new(driver_params)
    @driver.save
    auth_token = AuthenticateDriver.new(@driver.email, @driver.password).call
    response = { message: Message.account_created, auth_token: auth_token ,driver: @driver }
    json_response(response)
   end

  
  def update
    @driver_id=current_driver.id
    @driver=Driver.find(@driver_id)
    @driver.latitude=params[:latitude]
    @driver.longitude=params[:longitude]
    @driver.save
    json_response response= {messag: Message.success}
  end

  def reg_device_token
    @driver_id=@current_driver.id
    @driver=Driver.find(@driver_id)
    @driver.device_token=params[:device_token]
    @driver.save
    json_response response= {message: Message.success}
  end


  def signout
    @driver_id=current_driver.id
    @driver=Driver.find(@driver_id)
    @driver.status=0
    if @driver.save
      response={message: Message.success}
    end
    json_response(response)
  end
   
    def self.locations(order,vehicle)
        @vehicle = vehicle[0].vehicle_kind
        @Drivers_distances_array = []
        @DriversList=[]
        @driver_hash=Hash.new()
        @target_city=Geocoder.search("#{order.src_latitude},#{order.src_longitude}")
        @drivers = Driver.where("status = :status AND vehicle_kind = :kind ",
        {status: 1, kind: @vehicle})
        # Temp  
        # AND city = :city
        # ,city: @target_city.first.state
        # end of Temp
        if @drivers 
        @SourceLatitude=order.src_latitude
        @SourceLogitude=order.src_longitude
        @Destination_Latitude=order.dest_latitude
        @Destination_Logitude=order.dest_longitude
        
      
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
      
        #Sort Drivers Locations
        @Sorted_Drivers_Distances_Array=@Drivers_distances_array.sort
        # End of sorting drivers locations

        # Getting Nearest Driver
        @NearestDriver=@driver_hash[@Sorted_Drivers_Distances_Array[0]]
        # End of getting nearest driver
            
        #Final Sorted Drivers Obj
          @Sorted_Drivers_Distances_Array.each do |driverloc|
          @DriverObject=@driver_hash[driverloc]
         
          @DriversList.push(@DriverObject)
        end
        #End of SOrted Dirvers Obj
        
        render json:(self.assign_driver(@DriversList,order))
      else
        json_response({message: "no drivers"})
      end
         
      end


      def self.assign_driver(drivers,order)
        if drivers
        for driver in drivers do
          if  self.check_available?(driver,order)
            order.driver_id=driver.id
            order.save
            driver={name:driver.name ,phone: driver.phone ,vehicle_kind: driver.vehicle_kind}
            return response = {message: Message.success, driver: driver}                
          end
        end
      end
        return response = {message: Message.no_driver}       
      end
      
      def self.check_available?(driver, order)
        resp=DriverNotification.send_notification(order,driver.device_token)
        puts resp
        # sleep 120
        # order.status == 1 ? true : false
        true
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
        params.permit(:name,:phone,:email,:latitude,:longitude,:password,:vehicle_kind)
      end
end

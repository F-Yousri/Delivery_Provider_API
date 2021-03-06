
class OrdersController < ApplicationController
 require 'json'
#  before_action :authorize_request 
    def create 
        order = Order.new(order_params)
        @vehicle = Vehicle.where("min_weight <= :weight AND max_weight >= :weight",
        {weight: order.weight.to_i, weight: order.weight.to_i})
        json_response response={ message: Message.no_vehicle } and return if @vehicle.empty? 
    
        driver_response=DriversController.locations(order,@vehicle)
        vehicle=Vehicle.find(JSON.parse(driver_response)["driver"]["vehicle_id"])
       
        # distance between order source and destination
        @src_dest_distance=Geocoder::Calculations.distance_between([order.src_latitude,order.src_longitude], [order.dest_latitude,order.dest_longitude])
    
        order.cost= (@src_dest_distance*1.61)*vehicle["vehicle_cost_rate"]
        order.status=1
        if JSON.parse(driver_response)['message']=='success'
            order.save!
        else
            json_response(driver_response) and return
        end
        # parse response to add key& value to it
        driver_response=JSON.parse(driver_response)
        driver_response['cost']=order.cost
    
        json_response(driver_response)
    end
      
    def authorize_request
        @current_user = (AuthorizeApiRequestService.new(request.headers).call)[:user]
      end
    
    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:weight,:description,:pickup_location,:dropoff_location,:images)
    end
end

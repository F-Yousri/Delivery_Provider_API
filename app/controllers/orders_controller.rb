
class OrdersController < ApplicationController
 require 'json'
    def show 
        order = Order.new(order_params)
        @vehicle = Vehicle.where("min_weight <= :weight AND max_weight >= :weight",
        {weight: order.weight.to_i, weight: order.weight.to_i})
        json_response response={ message: Message.no_vehicle } and return if @vehicle.empty? 
        # json_response(@vehicle)
        driver_response=DriversController.locations(order,@vehicle)
        vehicle=Vehicle.find_by_vehicle_kind(JSON.parse(driver_response)["driver"]["vehicle_kind"])
       
        # distance between order source and destination
        @src_dest_distance=Geocoder::Calculations.distance_between([order.src_latitude,order.src_longitude], [order.dest_latitude,order.dest_longitude])
        # lat_lon = "#{order.src_latitude},#{order.src_longitude}"
        # @city = Geocoder.search(lat_lon).first
        # ss={city: @city.data['address_components'][4]}

        order.cost= (@src_dest_distance*1300)*vehicle["vehicle_cost_rate"]
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

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images,:weight,:description)
    end
end

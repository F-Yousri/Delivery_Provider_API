
class OrdersController < ApplicationController
 require 'json'
    def show 
        order = Order.new(order_params)
        @vehicle = Vehicle.where("min_weight <= :weight AND max_weight >= :weight",
        {weight: order.weight.to_i, weight: order.weight.to_i})
        # json_response(@vehicle)
        response=DriversController.locations(order,@vehicle)
        
        vehicle=Vehicle.find_by_vehicle_kind(JSON.parse(response)["driver"]["vehicle_kind"])
       
          # distance between order source and destination
        @src_dest_distance=Geocoder::Calculations.distance_between([order.src_latitude,order.src_longitude], [order.dest_latitude,order.dest_longitude])
        # response["distance"]=@src_dest_distance
        order.cost= (@src_dest_distance*1300)*vehicle["vehicle_cost_rate"]
        if JSON.parse(response)['message']=='success'
            order.save

        end
        render json: response
    end

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images,:weight)
    end
end

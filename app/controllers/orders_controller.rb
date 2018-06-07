
class OrdersController < ApplicationController
 require 'json'
    def show 
        order = Order.new(order_params)
        response=DriversController.locations(order)

        # order.cost= (distance*1300)*0.05
        if JSON.parse(response)['message']=='success'
            order.save

        end
        render json: response
    end

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images,:weight)
    end
end

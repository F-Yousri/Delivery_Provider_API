class OrdersController < ApplicationController
<<<<<<< HEAD
 
=======
    require 'json'
>>>>>>> 288b184d94633870b0931df4b851f8ed3fbcc93a
    def show 
        order = Order.new(order_params)
        response=DriversController.locations(params[:src_latitude],params[:src_longitude])
        distance = ((JSON response)["Distances"][0])

        order.cost= (distance*1300)*0.05
        if order.save
        render json: order
        end
    end

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images)
    end
end

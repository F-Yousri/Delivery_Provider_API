class OrdersController < ApplicationController

    def show 
        order = Order.create!(order_params)
        order.save
        render json: order
    end

    def order_params
        params.permit(:from,:to,:payment_method,:time,:title,:images)
    end
end

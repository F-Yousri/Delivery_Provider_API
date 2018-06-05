class OrdersController < ApplicationController

    def show 
        # order = Order.create!(order_params)
        # order.save
        ltd=31.2001
        lgt=29.9187
        response=DriversController.locations(ltd,lgt)
        render json: response

    end

    def order_params
        params.permit(:from,:to,:payment_method,:time,:title,:images)
    end
end

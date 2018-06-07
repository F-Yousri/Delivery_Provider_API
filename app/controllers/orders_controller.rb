class OrdersController < ApplicationController
 
    skip_before_action :authorize_request, only: :test
    def show 
        order = Order.new(order_params)
        response=DriversController.locations(params[:src_latitude],params[:src_longitude])
        if order.save
        render json: response
        end
    end
    def test
        json_response("hmaadaaa")
    end

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_lat,:dest_long,:payment_method,:time,:title,:images)
    end
end

class OrdersController < ApplicationController
    def show 
        render plain: request.body
    end
    
    def order_params
        params.permit(:from,:to,:provider_id,:payment_method,:time,:title,:images)
    end
end

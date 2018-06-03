class OrdersController < ApplicationController
    def show 
        data=params[:images]
        render json: data
    end
end

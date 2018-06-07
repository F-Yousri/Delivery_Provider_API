class VehiclesController < ApplicationController
    def get_vehicle
       
        @vehicle = Vehicle.where("min_weight <= :weight AND max_weight >= :weight",
        {weight: params[:weight].to_i, weight: params[:weight].to_i})
        json_response(@vehicle)
    end

    def driver_params
        params.permit(:weight)
      end

end

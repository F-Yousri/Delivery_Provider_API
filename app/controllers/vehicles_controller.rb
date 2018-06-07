class VehiclesController < ApplicationController
    def get_vehicle
        weight = params[:weight]
        # @vehicle = Vehicle.where('min-weight ','=<',weight)
        @vehicle = Vehicle.where("min_weight <= :mnweight AND max_weight >= :mxweight",
        {mnweight: weight.to_i, mxweight: weight.to_i})
        json_response(@vehicle)
    end

end

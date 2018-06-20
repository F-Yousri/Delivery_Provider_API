class Vehicle < ApplicationRecord
    validates :min_weight ,:max_weight ,:name ,:vehicle_cost_rate ,:vehicle_number , presence: true
    has_many :drivers

    # def name
    #     self.name=self.vehicle_kind
    # end
end

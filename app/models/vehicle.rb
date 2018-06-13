class Vehicle < ApplicationRecord
    validates :min_weight ,:max_weight ,:vehicle_kind ,:vehicle_cost_rate ,:vehicle_number , presence: true
end

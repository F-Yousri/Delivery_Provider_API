class Driver < ApplicationRecord
    # To Set address and get Lon & Lat
    # geocoded_by :address 
    # after_validation :geocode
    # To Set Long & Lat and get full address 
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode
end

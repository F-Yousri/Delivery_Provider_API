class Driver < ApplicationRecord
    # To Set address and get Lon & Lat
    # geocoded_by :address 
    # after_validation :geocode
    # To Set Long & Lat and get full address 
    # reverse_geocoded_by :latitude, :longitude
    # after_validation :reverse_geocode

    validates :latitude,:longitude,:name, :phone, :email, presence: true
    validates :phone, uniqueness: { message: 'Phone Already Exists' }
    validates :email, uniqueness: { message: 'Email Already Exists' }

end

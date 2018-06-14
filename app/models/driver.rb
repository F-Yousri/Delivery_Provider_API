class Driver < ApplicationRecord
    # To Set address and get Lon & Lat
    # geocoded_by :address 
    # after_validation :geocode
   
    has_secure_password
    enum status: { offline: 0, online: 1, busy: 2 }

    validates :latitude,:longitude,:name, :phone, :email, :password_digest, :vehicle_kind, presence: true
    validates :phone, uniqueness: { message: 'Phone Already Exists' }
    validates :email, uniqueness: { message: 'Email Already Exists' }

end

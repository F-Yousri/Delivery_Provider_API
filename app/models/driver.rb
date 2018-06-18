class Driver < ApplicationRecord
    
    reverse_geocoded_by :latitude, :longitude, :address => :city do |obj,results|
        if geo = results.first
          obj.city = geo.state
        end
      end

    after_validation :reverse_geocode
   
    enum status: [:offline, :online, :busy]
    has_many :orders
    validates :latitude,:longitude,:name, :phone, :email, :password_digest, :vehicle_kind, presence: true
    validates :phone, uniqueness: { message: 'Phone Already Exists' }
    validates :email, uniqueness: { message: 'Email Already Exists' }

end

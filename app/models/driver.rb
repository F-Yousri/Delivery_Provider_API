class Driver < ApplicationRecord
    validates :latitude,:longitude,:name, :phone, :email, presence: true
    validates :phone, uniqueness: { message: 'Phone Already Exists' }
    validates :email, uniqueness: { message: 'Email Already Exists' }
end

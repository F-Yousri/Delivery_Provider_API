class Order < ApplicationRecord
    enum status: [ :pending, :active, :upcoming, :history, :canceled ]
    validates :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images,:weight,:description, presence: true
    
end

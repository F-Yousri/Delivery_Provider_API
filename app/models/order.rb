class Order < ApplicationRecord
    # reverse_geocoded_by :src_latitude, :src_longitude
    # after_validation :reverse_geocode

    validates :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:images,:weight,:description, presence: true
end

class Order < ApplicationRecord
    enum status: [ :pending, :active, :upcoming, :history, :canceled ]
    validates :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:payment_method,:time,:title,:weight,:description, presence: true
    belongs_to :driver    

    def order_id
        self.order_id = self.id
    end
    
end

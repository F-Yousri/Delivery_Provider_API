class User < ApplicationRecord

    validates_presence_of  :domain, :secret_key
end

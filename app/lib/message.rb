class Message
    def self.success
        "success"
    end
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end
  
    def self.invalid_credentials
      'Invalid credentials'
    end

    def self.no_driver
      'Sorry, no driver available for your order'
    end

    def self.no_vehicle
      'Sorry, no vehicle available is suitable for your order'
    end

    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_not_created
      'Account could not be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end

    def self.driver_logout
      'Succesfully logged out'
    end

    def self.driver_is_offline
      ' Your are not logged in'
    end

    def self.order_already_deliverd
      'Order Already Deliverd '
    end
  end
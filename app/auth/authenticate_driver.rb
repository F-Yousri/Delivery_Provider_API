class AuthenticateDriver
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    # Service entry point
    def call
      JsonWebToken.encode(driver_id: driver.id) if driver
    end
  
    private
  
    attr_reader :email, :password
  
    # verify driver credentials
    def driver
      driver = Driver.find_by(email: email)
      return driver if driver && driver.authenticate(password)
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end
  
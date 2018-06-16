class AuthenticateUser
  def initialize(domain, secret_key)
    @domain = domain
    @secret_key = secret_key
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :domain, :secret_key

  # verify user credentials
  def user
    user = User.find_by(domain: domain)
    return user if user && user.secret_key == secret_key  
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
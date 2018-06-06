class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
  
    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_driver
  
    private
  
    # Check for valid request token and return driver
    def authorize_request
      @current_driver = (AuthorizeApiRequest.new(request.headers).call)[:driver]
    end
end

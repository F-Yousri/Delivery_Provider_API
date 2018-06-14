class ApplicationController < ActionController::Base
    include Response
    include ExceptionHandler

    before_action :cors_set_access_control_headers

    def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = '*'
        headers['Access-Control-Max-Age'] = "1728000"
      end
    # called before every action on controllers
  
    attr_reader :current_driver
  
    private
  
    # Check for valid request token and return driver
   
end

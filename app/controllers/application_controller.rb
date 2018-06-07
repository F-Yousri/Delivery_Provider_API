class ApplicationController < ActionController::Base
    include Response
    include ExceptionHandler
  
    # called before every action on controllers
  
    attr_reader :current_driver
  
    private
  
    # Check for valid request token and return driver
   
end

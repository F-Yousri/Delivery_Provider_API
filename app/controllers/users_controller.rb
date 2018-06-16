class UsersController < ApplicationController
    before_action :authorize_request
    before_action :check_duplication , only: :create
    skip_before_action :authorize_request, only: :create

    def authorize_request
      @current_user = (AuthorizeApiRequestService.new(request.headers).call)[:user]
    end

   def create
    @user=User.new(user_params)
    @user.save
    auth_token = AuthenticateDriver.new(@user.domain, @user.password).call
    response = { message: Message.account_created, auth_token: auth_token ,user: @user }
    # render json: @driver
    json_response(response, :created)
   end
   def check_duplication
    if User.find_by_domain(driver_params[:domain])
        @response = {message: "domain Already Exists"}
        render json: @response      
    end
  end
  def user_params
    params.permit(:domain,:secrt_key)
  end
  end
# frozen_string_literal: true

class AuthenticationController < ApplicationController
    skip_before_action :authorize_request ,only: :authenticate

  def authenticate
    auth_token =AuthenticateDriver.new(auth_params[:email], auth_params[:password]).call
    @driver=Driver.find_by_email(params[:email])
    @driver.status= 1
    @driver.save
    json_response(auth_token: auth_token,driver: @driver)
    end

  private

  def auth_params
    params.permit(:email, :password)
  end
end

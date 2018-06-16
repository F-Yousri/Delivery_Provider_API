# frozen_string_literal: true

class AuthenticationUserController < ApplicationController
    before_action :authorize_request ,except: :authenticate

  def authenticate
    auth_token =AuthenticateUser.new(auth_params[:domain], auth_params[:secret_key]).call
    json_response({message: Message.success,auth_token: auth_token})
    end

  private

  def auth_params
    params.permit(:domain, :secret_key)
  end
end

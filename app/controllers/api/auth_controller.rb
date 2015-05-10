class Api::AuthController < ApplicationController

  skip_before_action :authenticate_request

  def authenticate
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def authenticate_commenter
    commenter = Commenter.find_by_email(params[:email])
    unless commenter
      commenter = Commenter.create!(name: params[:username], email: params[:email])
    end
    if commenter
      render json: { auth_token: commenter.generate_auth_token }
    else
      render json: { error: 'Invalid name or email' }, status: :unauthorized
    end
  rescue => e
    byebug
    render json: { error: 'Could not create or authenticate user'}, status: :unauthorized
  end

  private
    def auth_params
      params.require(:auth).permit(:username, :password, :email)
    end
end

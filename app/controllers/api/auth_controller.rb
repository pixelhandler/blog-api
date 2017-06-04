class Api::AuthController < ApplicationController

  def authenticate
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      @current_user = user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def authenticate_commenter
    commenter = Commenter.find_by_email(params[:email])
    unless commenter.present?
      commenter = Commenter.create!(name: params[:username], email: params[:email])
    end
    if commenter.present?
      @current_user = commenter
      render json: { auth_token: commenter.generate_auth_token, commenter_id: commenter.id }
    else
      render json: { error: 'Invalid name or email' }, status: :unauthorized
    end
  rescue Exception => e
    render json: { error: e.message }, status: :unauthorized
  end

  private
    def auth_params
      params.require(:auth).permit(:username, :password, :email)
    end
end

class SessionsController < ApplicationController
  skip_before_action :ensure_authenticated_user, only: %i(new create)

  def new
  end

  def create
    create_user(params[:user_name])
    redirect_to root_url
  end
end

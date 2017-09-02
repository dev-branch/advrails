class UsersController < ApplicationController
  before_action :auth_teacher

  def index
    @users = User.order(id: 'asc')
  end

  def edit_role
    @roles = ['teacher', 'student']
  end

  def update_role
    user = User.where(email: params[:email]).first
    if !user
      @roles = ['teacher', 'student']
      @error = 'user does not exist'
      render 'edit_role'
    else
      user.update(role: params[:role])
      redirect_to users_path
    end
  end
end

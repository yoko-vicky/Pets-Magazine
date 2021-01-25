class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'Successfully logged in...'
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Something is wrong'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end
end

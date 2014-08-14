class UsersController < ApplicationController

  #if I want the landing page for users not to be index or show do I need to create those anyway?
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @is_signup = true
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_type, :food_category))
    if @user.save
       session[:user_id] = @user.id.to_s
        if @user.user_type == 'truck owner'
          redirect_to new_food_truck_path
        else
          redirect_to users_path
        end
    else
      redirect_to new_user_path
    end
  end

  #I only want the user logged in to be able to destroy or edit their own records
  def destroy
    if 
      User.find(params[:id]).destroy
      redirect_to root_path #???????
    else
      
    end
  end


end
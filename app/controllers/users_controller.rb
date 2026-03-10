class UsersController < ApplicationController
  def new
  end

  def create
    @existing_user = User.find_by({ "email" => params["email"] })
    if @existing_user != nil
      flash["notice"] = "Email already taken."
      redirect_to "/users/new"
    else
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      redirect_to "/"
    end
  end
end

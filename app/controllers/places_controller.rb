class PlacesController < ApplicationController

  def index
    if @current_user != nil
      @places = Place.where({ "user_id" => @current_user["id"] })
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

  def show
    if @current_user != nil
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"] })
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

  def new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = @user["id"]
      @place.save
      redirect_to "/places"
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

end
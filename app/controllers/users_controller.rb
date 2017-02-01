class UsersController < ApplicationController
  def index
    results = User.where('name like ?', "%#{params[:user][:name]}%")
    render json: results
  end
end

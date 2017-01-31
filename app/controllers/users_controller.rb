class UsersController < ApplicationController
  def user_list
    results = User.where('name LIKE(?)', '%' + params[:name] + '%')
end

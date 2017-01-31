class UsersController < ApplicationController
  def user_list
    @results = User.where('name LIKE(?)', '%' + params[:name] + '%')
    respond_to do |format|
      format.html { redirect_to new_chat_group_path }
      format.json
    end
  end
end

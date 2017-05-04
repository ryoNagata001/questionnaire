class UsersController < ApplicationController
  layout :set_layout
  def show
    @user = User.find(params[:id])
  end
end

class RoomsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @users = @company.users
  end

  def show
    @company = Company.find(params[:company_id])
    @room = Room.find(params[:id])
    @user = User.find(@room.user.id)
    @chief = User.find(@room.chief_id)
    @contents = @room.chats
    @content = Chat.new
  end
end

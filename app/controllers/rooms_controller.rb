class RoomsController < ApplicationController
  layout :set_layout
  before_action :authentication_chief_user, only: [:index]
  def index
    @company = Company.find(params[:company_id])
    @users = @company.users
  end

  def show
    @company = Company.find(params[:company_id])
    @room = Room.find(params[:id])
    @user = User.find(@room.user.id)
    if User.find(@room.chief_id).nil?
      redirect_to '/', notice: '今は担当者がいません'
    else
      @chief = User.find(@room.chief_id)
    end
    authentication_company_member
    @contents = @room.chats
    @content = Chat.new
  end

end

class RoomsController < ApplicationController
  def index
    are_you_chief?
    @company = Company.find(params[:company_id])
    @users = @company.users
  end

  def show
    @company = Company.find(params[:company_id])
    @room = Room.find(params[:id])
    @user = User.find(@room.user.id)
    @chief = User.find(@room.chief_id)
    can_you_access?
    @contents = @room.chats
    @content = Chat.new
  end

  private

    def are_you_chief?
      if current_user.nil?
        redirect_to '/', notice: "please sign in as a user"
      elsif current_user.id != Company.find(params[:company_id]).chief_id
        redirect_to '/', notice: "you can not access this page"
      end
    end

    def can_you_access?
      if current_user.nil?
        redirect_to '/', notice: "please sign in as a user"
      elsif current_user.id != @user.id && current_user.id != @company.chief_id
        redirect_to '/', notice: "you can not look this chat."
      end
    end
end

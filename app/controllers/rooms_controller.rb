class RoomsController < ApplicationController
  layout :set_layout
  def index
    not_chief_redirect_to_top
    @company = Company.find(params[:company_id])
    @users = @company.users
  end

  def show
    @company = Company.find(params[:company_id])
    @room = Room.find(params[:id])
    @user = User.find(@room.user.id)
    @chief = User.find(@room.chief_id)
    not_company_member_redirect_to_top
    @contents = @room.chats
    @content = Chat.new
  end

  private

    def not_chief_redirect_to_top
      if current_user.nil?
        redirect_to '/', notice: "please sign in as a user"
      elsif current_user.id != Company.find(params[:company_id]).chief_id
        redirect_to '/', notice: "you can not access this page"
      end
    end

    def not_company_member_redirect_to_top
      if current_user.nil?
        redirect_to '/', notice: "please sign in as a user"
      elsif current_user.id != @user.id && current_user.id != @company.chief_id
        redirect_to '/', notice: "you can not look this chat."
      end
    end
end

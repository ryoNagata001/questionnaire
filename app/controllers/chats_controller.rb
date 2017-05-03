class ChatsController < ApplicationController
  layout :set_layout
  before_action :set_room, only: :create

  def create
    @company = Company.find(params[:company_id])
    @chat = @room.chats.create(chat_params)
    if @chat.save
      redirect_to company_room_path(
        company_id: @company.id,
        id: @room.id
      ), notice: 'your message was successfully send'
    else
      render :new
    end
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def chat_params
      params.require(:chat).permit(:content).merge(
        transmittion_user_id: current_user.id
      )
    end
end

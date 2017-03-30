class ChatsController < ApplicationController
  before_action :set_room, only: :create

  def create
    @company = Company.find(params[:company_id])
    @chat = @room.chats.create(chat_params)
    if @chat.save
      redirect_to company_room_path(
        company_id: @company.id,
        id: @room.id
      ), notice: 'your account was successfully created.'
    else
      render :new
    end
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def chat_params
      params.require(:chat).permit(:content)
    end
end

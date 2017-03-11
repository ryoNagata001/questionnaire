class ChatsController < ApplicationController
  before_action :set_room, only: :create
  def create
    @company = Company.find(params[:company_id])
    @chat = @room.chats.create(chat_params)
    respond_to do |format|
      if @chat.save
        format.html { redirect_to company_room_path(:company_id => @company.id, :id => @room.id), notice: 'your account was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chat_params
    params.require(:chat).permit(:content)
  end
end

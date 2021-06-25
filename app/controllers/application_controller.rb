class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :set_chat_rooms

  private

    def set_chat_rooms
      @chat_rooms = ChatRoom.all
    end

end

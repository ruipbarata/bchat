class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :set_chat_rooms
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def set_chat_rooms
      @chat_rooms = ChatRoom.all
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end

end

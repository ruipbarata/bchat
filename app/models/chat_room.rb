# == Schema Information
#
# Table name: chat_rooms
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chat_rooms_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ChatRoom < ApplicationRecord

  belongs_to :user
  has_many :messages, dependent: :destroy

end

# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_fb              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_one_attached :avatar, dependent: :destroy

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :email, presence: true
  validates :username,  length: { in: 3..10 },
                        uniqueness: true,
                        if: -> { username.present? }

  def name
    username || email.split("@")[0]
  end

  def avatar?
    avatar.attached? || avatar_fb.present?
  end

  def final_avatar
    return avatar if avatar.attached?
    return avatar_fb if avatar_fb.present?
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"]) &&
         (session["devise.facebook_data"]["extra"]["raw_info"] && user.email.blank?)
        user.email = data["email"]
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      user.avatar_fb = auth.info.image
    end
  end
end

# frozen_string_literal: true
Rails.logger.debug("Creating User")

user = User.where(
  name: "User_1"
).first_or_initialize(
  name: "User_1",
  email: "ruipbarata@gmail.com",
  password: ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"]
)

if user.present?
  user.update(
    name: "User_1",
    email: "ruipbarata@gmail.com",
    password: ENV["ADMIN_PASSWORD"],
    password_confirmation: ENV["ADMIN_PASSWORD"]
  )
else
  user.skip_confirmation!
  user.save!
end

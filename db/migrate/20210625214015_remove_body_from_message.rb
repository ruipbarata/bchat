# frozen_string_literal: true
class RemoveBodyFromMessage < ActiveRecord::Migration[6.1]
  def change
    remove_column(:messages, :body)
  end
end

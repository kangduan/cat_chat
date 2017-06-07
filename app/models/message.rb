class Message < ApplicationRecord
  after_create_commit { MessageRelayJob.perform_later self }
  belongs_to :chatroom
  belongs_to :user
end

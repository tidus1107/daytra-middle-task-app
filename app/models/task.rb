class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  belongs_to :board
end
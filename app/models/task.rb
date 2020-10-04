class Task < ApplicationRecord
  has_one_attached :eyecatch

  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  belongs_to :board
end

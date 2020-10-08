class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end

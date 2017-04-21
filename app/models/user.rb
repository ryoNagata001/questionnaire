class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :company
  has_one :room, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  mount_uploader :avatar, AvatarUploader
  has_many :answer_texts, dependent: :destroy
  has_many :answer_selects, dependent: :destroy
  has_many :user_surveys, dependent: :destroy
end

class Company < ApplicationRecord
  belongs_to :admin
  has_many :users, dependent: :destroy
  has_many :surveys, dependent: :destroy
end

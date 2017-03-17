class Company < ApplicationRecord
  belongs_to :admin
  has_many :users
  has_many :surveys
end

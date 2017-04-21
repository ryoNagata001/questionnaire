class Survey < ApplicationRecord
  belongs_to :company
  has_many :questions, dependent: :destroy
  has_many :user_survey, dependent: :destroy
end

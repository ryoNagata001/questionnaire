class Survey < ApplicationRecord
  belongs_to :company
  has_many :questions, dependent: :destroy
  has_many :user_survey, dependent: :destroy
  validates :company_id, presence: true
  validates :released, presence: true
end

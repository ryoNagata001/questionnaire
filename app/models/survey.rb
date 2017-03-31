class Survey < ApplicationRecord
  belongs_to :company
  has_many :questions, dependent: :destroy
end

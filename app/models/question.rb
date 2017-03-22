class Question < ApplicationRecord
  belongs_to :survey
  has_many :choises ,dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :choises, allow_destroy: true
end

class Choice < ApplicationRecord
  belongs_to :question, inverse_of: :choices
  has_many :answer_select, dependent: :destroy
end

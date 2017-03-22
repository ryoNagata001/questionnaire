class Choise < ApplicationRecord
  belongs_to :question, inverse_of: :choises
end

class AnswerText < ApplicationRecord
  belongs_to :question
  belongs_to :user
end

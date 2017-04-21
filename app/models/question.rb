class Question < ApplicationRecord
  belongs_to :survey
  has_many :choices, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :choices, allow_destroy: true
  TEXT_QUESTION_CATEGORY_IDS = [0, 1].freeze
  has_many :answer_texts, dependent: :destroy

  def text_question?
    TEXT_QUESTION_CATEGORY_IDS.include?(self.category_id)
  end
end

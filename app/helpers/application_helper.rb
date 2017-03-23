module ApplicationHelper

  def text_question?(question)
    Question::TEXT_QUESTION_CATEGORY_IDS.include?(question.category_id)
  end
end

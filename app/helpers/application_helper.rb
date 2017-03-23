module ApplicationHelper

  def text_question?(question)
    if question.category_id == 0 || question.category_id == 1 then
      true
    else
      false
    end
  end
end

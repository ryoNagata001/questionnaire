module ApplicationHelper

  def text_question?(question)
    Question::TEXT_QUESTION_CATEGORY_IDS.include?(question.category_id)
  end

  def admin?
    !(current_admin.nil?)
  end

  def sign_in_user?
    !(current_user.nil?)
  end

  def chief_user?
    company = Company.find(current_user.company_id)
    current_user.id == company.chief_id
  end

end

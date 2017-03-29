class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    unless Question::TEXT_QUESTION_CATEGORY_IDS.include?(@question.category_id)
      @choices = @question.choices
    end
    @company = Company.find(params[:company_id])
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @answer_select = AnswerSelect.new
  end

  def create_answer_text
    if current_user.nil?
      redirect_to '/'
    end
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
    @answer_text = AnswerText.create(answer_text_params)
    if @answer_text.save
      number = @survey.questions.index(@question)
      next_question = number + 1
      redirect_to company_survey_question_path(company_id: @survey.company_id, survey_id: @survey.id, id: @survey.questions[next_question].id)
    else
      render :show
    end
  end

  def create_answer_select
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
    user_id = current_user.id
    @answer_selects = answer_select_params
    @answer_selects[:choice_ids].each do |choice|
      @answer_select = AnswerSelect.create(user_id: user_id, choice_id: choice)
      unless @answer_select.save
        render :show
      end
    end
    number = @survey.questions.index(@question)
    next_question = number + 1
    redirect_to company_survey_question_path(company_id: @survey.company_id, survey_id: @survey.id, id: @survey.questions[next_question].id)
  end

  private

    def answer_text_params
      params.require(:answer_text).permit(:content).merge(question_id: @question.id, user_id: current_user.id)
    end

    def answer_select_params
      params.require(:answer_select).permit(choice_ids: [])
    end
end

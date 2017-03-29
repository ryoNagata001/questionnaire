class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    if !(Question::TEXT_QUESTION_CATEGORY_IDS.include?(@question.category_id))
      @choices = @question.choices
    end
    @company = Company.find(params[:company_id])
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
  end

  def create_answer_text
    if current_user == nil
      redirect_to "/"
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

  end

  private
    def answer_text_params
      params.require(:answer_text).permit(:content).merge(question_id: @question.id, user_id: current_user.id)
    end
end

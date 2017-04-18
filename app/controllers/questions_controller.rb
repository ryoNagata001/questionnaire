class QuestionsController < ApplicationController
  before_action :are_you_admin?, only: :edit

  def show
    are_you_company_member?
    @company = Company.find(params[:company_id])
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @answer_select = AnswerSelect.new
    @user_survey = UserSurvey.find_by(survey_id: @survey.id, user_id: current_user.id)
    @question = Question.find(params[:id])
    if @user_survey.question_number != @survey.questions.index(@question)
      redirect_to wrong_question_company_survey_questions_path(company_path: @company.id, survey_id: @survey.id)
    else
      if @user_survey.question_number != @survey.questions.index(@question)
      redirect_to '/', notice: '答える権限がありません'
      end
      unless Question::TEXT_QUESTION_CATEGORY_IDS.include?(@question.category_id)
        @choices = @question.choices
      end
    end
  end

  def wrong_question
  end

  def create_answer_text
    if current_user.nil?
      redirect_to '/'
    end
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
    @answer_text = AnswerText.new(answer_text_params)
    @user_survey = UserSurvey.find_by(survey_id: @survey.id, user_id: current_user.id)
    if @answer_text.save
      next_question_number = @survey.questions.index(@question) + 1
      @user_survey.update!(question_number: next_question_number)
      end_check
    else
      render :show
    end
  end

  def create_answer_select
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
    user_id = current_user.id
    @answer_selects = answer_select_params
    @user_survey = UserSurvey.find_by(survey_id: @survey.id, user_id: current_user.id)
    @answer_selects[:choice_ids].each do |choice|
      @answer_select = AnswerSelect.new(user_id: user_id, choice_id: choice)
      unless @answer_select.save
        render :show
      end
    end
    next_question_number = @survey.questions.index(@question) + 1
    @user_survey.update!(question_number: next_question_number)
    end_check
  end

  def destroy
    @survey = Survey.find(params[:survey_id])
    @company = Company.find(params[:company_id])
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to company_survey_path(company_id: @company.id, survey_id: @survey.id)
    else
      render '/'
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @company = Company.find(params[:company_id])
    @question = Question.find(params[:id])
  end

  def update_select
    @survey = Survey.find(params[:survey_id])
    @company = Company.find(params[:company_id])
    temp = params.require(:question).permit(
      :category_id,
      :title
    )
    @question = Question.find(params[:id])
    @question.update(temp)
    temp = params.require(:question).permit(choices_attributes: [:content, :id, :_destroy])
    temp[:choices_attributes].each do |key, choice|
      if choice[:id].nil?
        unless choice[:delete]
        Choice.create(question_id: @question.id, content: choice[:content])
        end
      else
        choice_target = Choice.find(choice[:id])
        if choice[:_destroy]
          Choice.destroy(choice_target)
        else
          choice_target.update(choice)
        end
      end
    end
    redirect_to company_survey_path(company_id: @company.id, id: @question.survey_id)
  end

  def update_text
    @survey = Survey.find(params[:survey_id])
    @company = Company.find(params[:company_id])
    temp = params.require(:question).permit(:category_id, :title)
    @question = Question.find(params[:id])
    @question.update(temp)
    redirect_to company_survey_path(company_id: @company.id, id: @question.survey_id)
  end

  private

    def answer_text_params
      params.require(:answer_text).permit(:category_id, :title).merge(
        question_id: @question.id,
        user_id: current_user.id
      )
    end

    def answer_select_params
      params.require(:answer_select).permit(choice_ids: [])
    end

    def end_check
      @company = Company.find(params[:company_id])
      if (@survey.questions.index(@question) + 1) == (@survey.questions.count)
        redirect_to end_of_question_company_survey_path(company_id: @company.id, id: @survey.id)
      else
        redirect_to company_survey_question_path(
          company_id: @survey.company_id,
          survey_id: @survey.id,
          id: @survey.questions[@survey.questions.index(@question) + 1].id
    )
      end
    end

    def are_you_admin?
      if current_admin.nil?
        redirect_to '/', notice: "you can not access this page"
      end
    end

    def are_you_company_member?
      if current_user.nil?
        redirect_to '/', notice: "please sign in as a user to show this page"
      elsif current_user.company_id != params[:company_id].to_i
        redirect_to '/', notice: 'you do not have right to access'
      end
    end
end

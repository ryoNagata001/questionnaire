class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :set_company

  # GET /surveys
  def index
    @surveys = @company.surveys
  end

  # GET /surveys/1
  def show
    @survey = Survey.find(params[:id])
    @questions = @survey.questions
    @question = Question.new
    @question.choices.build
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit; end

  # POST /surveys
  def create
    @survey = @company.surveys.create(survey_params)
    if @survey.save
      redirect_to company_path(@company), notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /surveys/1
  def update
    if @survey.update(survey_params)
      redirect_to company_survey_path(
        company_id: @survey.company_id,
        id: @survey.id
      ), notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /surveys/1
  def destroy
    @survey.destroy
    redirect_to company_surveys_url(@company), notice: 'Survey was successfully destroyed.'
  end

  def text_create
    @survey = Survey.find(params[:id])
    @question = @survey.questions.create(question_params)
    if @question.save
      redirect_to company_survey_path(
        company_id: @company.id,
        id: @survey.id
      ), notice: 'テキストボックスが追加されました'
    else
      render :show
    end
  end

  def select_create
    @survey = Survey.find(params[:id])
    @question = Question.create(question_params)
    if @question.save
      redirect_to company_survey_path(
        company_id: @company.id,
        id: @survey.id
      ), notice: 'チェックボックスが追加されました'
    else
      render :show
    end
  end

  def result
    @survey = Survey.find(params[:id])
    @questions = @survey.questions
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    def survey_params
      params.require(:survey).permit(:title)
    end

    def question_params
      params.require(:question).permit(
        :title,
        :category_id,
        choices_attributes: [:id, :content, :question_id, :_destroy]
      ).merge(survey_id: @survey.id)
    end

    def create_select
      @survey = Survey.find(params[:id])
      @question = Question.create(question_params)
      @question.survey_id = @survey.id
    end
end

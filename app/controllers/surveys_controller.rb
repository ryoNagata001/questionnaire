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
    @question.choises.build
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  def create
    @survey = @company.surveys.create(survey_params)
    respond_to do |format|
      if @survey.save
        format.html { redirect_to company_path(@company), notice: 'Survey was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /surveys/1
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to company_survey_path(:company_id => @survey.company_id, :id => @survey.id), notice: 'Survey was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /surveys/1
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to company_surveys_url(@company), notice: 'Survey was successfully destroyed.' }
    end
  end

  def text_create
    @survey = Survey.find(params[:id])
    @question = @survey.questions.create(question_params)
    if @question.save
      redirect_to company_survey_path(company_id: @company.id, id: @survey.id), notice: 'テキストボックスが追加されました'
    else
      render :show
    end
  end

  def select_create
    @survey = Survey.find(params[:id])
    @question = Question.create(question_params)
    if @question.save
      redirect_to company_survey_path(company_id: @company.id, id: @survey.id), notice: 'チェックボックスが追加されました'
    else
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

     def set_company
      @company = Company.find(params[:company_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:title)
    end

    def question_params
      params.require(:question).permit(
      :title,
      :category_id,
      choises_attributes: [:id, :content, :question_id, :_destroy]).merge(survey_id: @survey.id)
    end

    def create_select
      @survey = Survey.find(params[:id])
      @question = Question.create(question_params)
      @question.survey_id = @survey.id
    end
end

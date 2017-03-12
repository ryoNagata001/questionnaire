class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :set_company

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = @company.surveys
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
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
  # PATCH/PUT /surveys/1.json
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
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to company_surveys_url(@company), notice: 'Survey was successfully destroyed.' }
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
end

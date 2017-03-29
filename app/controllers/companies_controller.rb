class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/1
  def show
    @users = @company.users
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  def create
    @company = Company.new(company_params)
    @company.admin_id = current_admin.id

    if @company.save
      redirect_to company_new_chief_path(@company.id), notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    if @company.destroy
      redirect_to companies_path, notice: 'Company was successfully destroyed.'
    else
      render :show
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :password)
    end
end

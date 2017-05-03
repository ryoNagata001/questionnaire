class CompaniesController < ApplicationController
  layout :set_layout
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_admin, only: [:index, :show, :new, :edit]

  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/1
  def show
    @chief = User.find(@company.chief_id)
    @users = @company.users
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    @users = User.where(company_id: @company.id).pluck(:name, :id)
  end

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
    if company_params[:chief_id] != @company.chief_id
      Room.destroy_all(chief_id: @company.chief_id)
    end
    if @company.update(company_params)
      delay.create_rooms
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
      params.require(:company).permit(:name, :password, :chief_id)
    end

    def create_rooms
      @company.users.each do |user|
        if user.id != @company.chief_id
          Room.create(chief_id: @company.chief_id, user_id: user.id)
        end
      end
    end

    def redirect_if_not_admin
      if current_admin.nil?
        redirect_to '/', notice: 'You do not have right to access.'
      end
    end
end

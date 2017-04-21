class Users::RegistrationsController < Devise::RegistrationsController
  layout :set_layout
  before_action :configure_sign_up_params, only: [:create, :create_chief]
  before_action :nil_user_redirect_to_top, only: [:show, :new_chief, :edit]
  before_action :current_user_redirect_to_top, only: [:new_chief, :new]

  # before_action :configure_account_update_params, only: [:update]
  def create
    @company = Company.find(params[:company_id])
    @user = @company.users.create(user_params)
    ActiveRecord::Base.transaction do
      @user.save!
      @room = Room.new(
        user_id: @user.id,
        chief_id: @company.chief_id
      )
      @room.save!
    end
      redirect_to company_path(@company), notice: 'Send email to your address, please check your account'
    rescue => e
      render :new
  end

  def create_chief
    @company = Company.find(params[:company_id])
    @user = @company.users.create(user_params)
    ActiveRecord::Base.transaction do
      @user.save!
      @company.chief_id = @user.id
      @company.update!
    end
      redirect_to company_path(@company), notice: 'chief user was successfully created'
    rescue => e
      render :new
  end

  def new_chief
    @company = Company.find(params[:company_id])
    @user = User.new
  end

  # GET /resource/sign_up
  def new
    @company = Company.find(params[:company_id])
    super
  end

  # GET /resource/edit
  def edit
    unless current_admin.nil?
      redirect_to '/', notice: 'you can not access this page'
    end
    @user = current_user
  end

  def destroy
    @company = Company.find(params[:company_id])
    @user = User.find(params[:id])
    if User.destroy(@user)
      redirect_to company_rooms_path(company_id: @company.id)
    end
  end

  # PUT /resource
  def update
    @company = Company.find(params[:company_id])
    if resource.update_with_password(user_params)
      redirect_to company_user_path(
        company_id: @company.id,
        id: current_user.id
      ), notice: 'your account was successfully updated.'
    else
      render :edit
    end
  end

  private

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      super(resource)
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      super(resource)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :current_password,:password_confirmation,:password, :avatar, :email)
    end

    def nil_user_redirect_to_top
      if current_user.nil? && current_admin.nil?
        redirect_to '/', notice: 'please sign in at fast'
      end
    end

    def other_user_redirect_to_top
      if current_user.id != @user.id
        redirect_to '/', notice: 'you do not have right to access this page'
        end
    end

    def current_user_redirect_to_top
      unless current_user.nil?
        redirect_to '/', notice: 'you can not access this page'
      end
    end
end

class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create, :create_chief]
before_action :set_company, only: [:create, :new, :create_chief, :new_chief]
# before_action :configure_account_update_params, only: [:update]
def create
  @user = @company.users.create(user_params)
  respond_to do |format|
    if @user.save
      format.html { redirect_to company_path(@company), notice: 'your account was successfully created.' }
    else
      format.html { render :new }
    end
 
end
def create_chief
  @user = @company.users.create(user_params)
  respond_to do |format|
    if @user.save
      @company.chief_id = @user.id
      if @company.save
        format.html { redirect_to company_path(@company), notice: 'chief user was successfully created' }
      else
        format.html { render :new }
      end
    else
      format.html { render :new }
    end
  end
end
def new_chief
  @user = User.new
end

  # GET /resource/sign_up
  # def new
  #  super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

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
private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:company_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :avatar, :email)
    end
    def create_user
  @user = @company.users.create(user_params)
  respond_to do |format|
    if @user.save
      format.html { redirect_to company_path(@company), notice: 'your account was successfully created.' }
    else
      format.html { render :new }
    end
  end
end



end

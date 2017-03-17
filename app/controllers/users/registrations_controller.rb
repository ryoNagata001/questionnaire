class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create, :create_chief]

# before_action :configure_account_update_params, only: [:update]
def create
  @company = Company.find(params[:company_id])
  @user = @company.users.create(user_params)
  @room = Room.new
  @room.user_id = @user.id
  @room.chief_id = @company.chief_id
  respond_to do |format|
    if @user.save
      if @room.save
        format.html { redirect_to company_path(@company), notice: 'your account was successfully created.' }
      else
        format.html { render :new }
      end
    else
      format.html { render :new }
    end
  end
end

def create_chief
  @company = Company.find(params[:company_id])
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
     @user = current_user
   end

  # PUT /resource
  def update
    @company = Company.find(params[:company_id])
    if @company.users.update(user_params)
      redirect_to company_user_path(:company_id => @company.id, :id => current_user.id), notice: 'your account was successfully updated.'
    else
      render :edit
    end
  end

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
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:name, :password, :avatar, :email)
      end
end

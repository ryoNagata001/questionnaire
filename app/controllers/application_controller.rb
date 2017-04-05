class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_locale
    @locale = params[:locale]
    if @locale == "en"
      I18n.locale = :en
    else
      I18n.locale = :ja
    end
  end

end

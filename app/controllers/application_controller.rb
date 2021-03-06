class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_locale
    @locale = params[:locale]
    if @locale == 'en'
      I18n.locale = :en
    elsif @locale == 'ja'
      I18n.locale = :ja
    end
  end

  def set_layout
    if sign_in_user? && chief_user?
      'chief'
    elsif sign_in_user?
      'user'
    elsif admin?
      'admin'
    else
      'sign_out'
    end
  end

end

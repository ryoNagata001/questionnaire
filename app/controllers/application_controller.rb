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

  def authentication_admin
    if current_admin.nil?
      redirect_to '/', notice: 'ordinary user can not access this page'
    end
  end

  def authentication_company_member
    if current_user.nil?
      redirect_to '/', notice: 'please login to show this page'
    elsif current_user.company_id != params[:company_id].to_i
      redirect_to '/', notice: 'you can not access this page'
    end
  end

  def authentication_chief_user
    if current_user.nil?
      redirect_to '/', notice: 'you can not access this page'
    elsif current_user.id != Company.find(params[:company_id]).chief_id
      redirect_to '/', notice: 'you can not access this page'
    end
  end

  def authentication_user
    if current_user.nil?
      redirect_to '/', notice: 'please login to show this page'
    end
  end

  def redirect_survey_index_if_survey_released
    @survey = Survey.find(params[:survey_id])
    @company = Company.find(params[:company_id])
    if @survey.released
      redirect_to company_surveys_path(company_id: params[:company_id]), notice: '公開後のsurveyは編集できません'
    end
  end
end

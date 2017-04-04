class HomeController < ApplicationController
  before_action :set_locale
  def top
    @message = 'ようこそQuestionnaryへ'
  end

  def about; end

  private

    def set_locale
      @locale = params[:locale]
    end
end

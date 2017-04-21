class HomeController < ApplicationController
  layout :set_layout
  def top
    @message = 'ようこそQuestionnaryへ'
  end

  def about; end
end

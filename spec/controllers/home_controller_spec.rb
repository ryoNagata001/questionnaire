require 'rails_helper'

describe HomeController do
  before do
    I18n.locale = :en
  end

  before(:each) do
    login_user user
  end

  let(:user){create(:user)}

  describe 'GET #top' do
    it 'renders the :top template' do
      get :top
      expect(response).to render_template :top
    end
  end

  describe 'GET #about' do
    it 'renders the :about template' do
      get :about
      expect(response).to render_template :about
    end
  end
end

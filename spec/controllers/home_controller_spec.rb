require "rails_helper"
describe HomeController do
  describe 'home#top' do
    it 'render about page' do
      get :about
      expect(response).to render_template :about
    end
    it 'render top page' do
      get :top
      expect(response).to render_template :top
    end
  end
end

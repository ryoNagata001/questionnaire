require 'rails_helper'

describe QuestionsController do
  before do
    I18n.locale = :en
  end

  let(:company){ create(:company) }
  let(:survey){ create(:survey, company: company) }
  let(:question){ create(:question, survey: survey) }
  let!(:user_survey){ create(:user_survey, survey: survey, user: user, question_number: survey.questions.index(question)) }
  let(:user){ create(:user) }
  describe 'GET #show' do
    before do
      login_user user
      get :show, params: {id: question, company_id: company.id, survey_id: survey.id}
    end

    it 'renders the :show template' do
      expect(response).to render_template 'show'
    end
  end

  describe 'GET #wrong_question' do
    it 'redirect to / if user is\'t company member'
  end

  describe 'GET #edit' do
    it 'assigns thr requested question to @question'
    it 'renders the :edit template'
  end

  describe 'post #create_answwer_text' do
    context 'with valid attributes' do
      it 'save the new text_answer in the database'
    end
    context 'with invalid attributes' do
      it 'does not save the new text_answer in the database'
      it 'render :show template'
    end
  end

  describe 'post #create_answer_select' do
    context 'with valid attributes' do
      it 'save the new choice'
    end
    context 'with invalid attributes' do
      it 'does not save the new choice in the database'
      it 'render :show template'
    end
  end

  describe 'PATCH #update_select' do
    context 'with valid attributes' do
      it 'updates the question in database'
      it 'updates the choice in database'
    end
    context 'with invalid attributes' do
      it 'does not update the question'
    end
  end

  describe 'PATCH #update_text' do
    context 'with valid attributes' do
      it 'updates the question in database'
    end
    context 'eith invalid attributes' do
      it 'does not update the question'
    end
  end

  describe 'DELETE #destroy' do
    it 'delete the question from the database'
  end
end

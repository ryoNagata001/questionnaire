require 'rails_helper'

describe QuestionsController do
  before do
    I18n.locale = :en
  end

  let(:company) { create(:company) }
  let(:survey) { create(:survey, company: company) }
  let(:unreleased_survey) { create(:survey, company: company, released: false) }
  let(:question) { create(:question, survey: survey) }
  let(:select_question) { create(:select_question, survey: survey) }
  let(:choice) { create(:choice, question: select_question) }
  let!(:user_survey) { create(:user_survey, survey: survey, user: user, question_number: survey.questions.index(question)) }
  let(:admin) { create(:admin) }
  let(:user) { create(:user, company: company) }

  describe 'GET #show' do
    context 'user is login' do
      before do
        login_user user
        get :show, params: { id: question, company_id: company.id, survey_id: survey.id }
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end

      it 'assign the requested question to @question' do
        expect(assigns(:question)).to eq question
      end
      it 'assign the requested user_survey to @user_survey' do
        expect(assigns(:user_survey)).to eq user_survey
      end
      it 'assign the requested survey to @survey' do
        expect(assigns(:survey)).to eq survey
      end
    end
    context 'admin is login' do
      before do
        login_admin admin
        get :show, params: { id: question, company_id: company.id, survey_id: survey.id }
      end
      it 'redirect to / ' do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #wrong_question' do
    it 'redirect to / if user isn\'t company member' do
      get :wrong_question, params: { id: question, company_id: company.id, survey_id: survey.id }
      expect(response).to render_template :wrong_question
    end
  end

  describe 'GET #edit' do
    before do
      login_admin admin
      get :edit, params: { id: question, company_id: company.id, survey_id: unreleased_survey.id }
    end
    it 'assigns thr requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'post #create_answwer_text' do
    before do
      login_user user
    end
    context 'with valid attributes' do
      it 'save the new text_answer in the database' do
        expect {
          post :create_answer_text, params: { answer_text: attributes_for(:answer_text), id: question.id, company_id: company.id, survey_id: survey.id }
        }.to change(AnswerText, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'does not save the new text_answer in the database' do
        expect {
          post :create_answer_text, params: { answer_text: attributes_for(:answer_text, content: ''), id: question.id, company_id: company.id, survey_id: survey.id }
        }.not_to change(AnswerText, :count)
      end
    end
  end

  describe 'post #create_answer_select' do
    before do
      login_user user
    end
    context 'with valid attributes' do
      it 'save the new choice' do
        expect {
          post :create_answer_select, params: { answer_select: { choice_ids: [choice.id] }, id: question.id, company_id: company.id, survey_id: survey.id }
        }.to change(AnswerSelect, :count).by(1)
      end
    end
  end

  describe 'PATCH #update_select' do
    before do
      login_admin admin
    end
    context 'with valid attributes' do
      it 'localtes the requested @question' do
        patch :update_select, params: { question: { choices_attributes: [choice], title: 'hogehoge' }, id: select_question.id, company_id: company.id, survey_id: unreleased_survey.id }
        expect(assigns(:question)).to eq select_question
      end
      it 'changes @questions\'s attributes' do
        patch :update_select, params: { question: { choices_attributes: [choice], title: 'hogehoge' }, id: select_question.id, company_id: company.id, survey_id: unreleased_survey.id }
        select_question.reload
        expect(select_question.category_id).to eq(2)
        expect(select_question.title).to eq('hogehoge')
      end
    end
  end

  describe 'PATCH #update_text' do
    before do
      login_admin admin
    end
    context 'with valid attributes' do
      it 'locates the requested @question' do
        patch :update_text, params: { question: attributes_for(:question, title: 'hogehoge'), id: question.id, company_id: company.id, survey_id: unreleased_survey.id }
        expect(assigns(:question)).to eq question
      end
      it 'changes @questions\'s attributes' do
        patch :update_text, params: { question: attributes_for(:question, title: 'hogehoge'), id: question.id, company_id: company.id, survey_id: unreleased_survey.id }
        question.reload
        expect(question.title).to eq('hogehoge')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_admin admin
    end
    it 'delete the question from the database' do
      expect {
        delete :destroy,
        params: { id: question, company_id: company.id, survey_id: unreleased_survey.id }
      }.to change(Question, :count).by(-1)
    end
  end
end

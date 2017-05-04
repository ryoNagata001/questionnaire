require 'rails_helper'

describe Question do
  before do
    I18n.locale = :en
  end

  it "has a valid factory" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  it "is invaild without a survey_id" do
    question = build(:question, survey_id: nil)
    question.valid?
    expect(question.errors[:survey_id]).to include("can't be blank")
  end

  it "is invaild without a category_id" do
    question = build(:question, category_id: nil)
    question.valid?
    expect(question.errors[:category_id]).to include("can't be blank")
  end

  it "returns true if category_id == 0" do
    question = build(:question, category_id: 0)
    expect(question.text_question?).to eq true
  end

  it "returns true if category_id == 1" do
    question = build(:question, category_id: 1)
    expect(question.text_question?).to eq true
  end

  it "returns false if category_id == 2" do
    question = build(:select_question)
    expect(question.text_question?).to eq false
  end

  it "returns true if category_id == 3" do
    question = build(:question, category_id: 3)
    expect(question.text_question?).to eq false
  end
end

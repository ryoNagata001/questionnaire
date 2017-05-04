require 'rails_helper'

describe Survey do
  before do
    I18n.locale = :en
  end
  it "has a valid factory" do
    expect(build(:survey)).to be_valid
  end
  it "is invaild without a company_id" do
    survey = build(:survey_does_not_have_company)
    survey.valid?
    expect(survey.errors[:company_id]).to include("can't be blank")
  end
end

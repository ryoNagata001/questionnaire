require 'rails_helper'

describe Survey do
  before do
    I18n.locale = :en
  end
  it "is valid with a company_id and released" do
    company = Company.create(id: 1)
    survey = Survey.create(company_id: company.id, released: 1)
    expect(survey).to be_valid
  end
  it "is invaild without a company_id" do
    survey = Survey.new(company_id: nil)
    survey.valid?
    expect(survey.errors[:company_id]).to include("can't be blank")
  end
  it "is invaild without a released" do
    survey = Survey.new(released: nil)
    survey.valid?
    expect(survey.errors[:released]).to include("can't be blank")
  end
end

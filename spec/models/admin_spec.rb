require 'rails_helper'

describe Admin do
  before do
    I18n.locale = :en
  end
  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end

  let(:admin_without_email){ build(:admin, email: nil) }
  it "is invalid without a email" do
    admin_without_email.valid?
    expect(admin_without_email.errors[:email]).to include("can't be blank")
  end

  let(:admin_without_name){ build(:admin, name: nil) }
  it "is invalid without a name" do
    admin_without_name.valid?
    expect(admin_without_name.errors[:name]).to include("can't be blank")
  end

  let(:admin_without_password){ build(:admin, password: nil) }
  it "is invalid without a password" do
    admin_without_password.valid?
    expect(admin_without_password.errors[:password]).to include("can't be blank")
  end

  let(:admin_has_too_long_name){ build(:too_long_name_admin)}
  it "is invaild with a too long name" do
    admin_has_too_long_name.valid?
    expect(admin_has_too_long_name.errors[:name]).to include("is too long (maximum is 20 characters)")
  end

  let(:admin_has_same_email){ build(:same_email_admin) }
  it "is invalid with a same email" do
    create(:same_email_admin)
    admin_has_same_email.valid?
    expect(admin_has_same_email.errors[:email]).to include("has already been taken")
  end
end

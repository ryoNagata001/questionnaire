require 'rails_helper'

describe Admin do
  before do
    I18n.locale = :en
  end
  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end
  it "is valid with a unique emaili, password and name" do
    admin = build(:admin)
    expect(admin).to be_valid
  end
  it "is invalid without a email" do
    admin = build(:admin, email: nil)
    admin.valid?
    expect(admin.errors[:email]).to include("can't be blank")
  end
  it "is invalid without a name" do
    admin = build(:admin, name: nil)
    admin.valid?
    expect(admin.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a password" do
    admin = build(:admin, password: nil)
    admin.valid?
    expect(admin.errors[:password]).to include("can't be blank")
  end
  it "is invaild with a too long name" do
    admin = build(:too_long_name_admin)
    admin.valid?
    expect(admin.errors[:name]).to include("is too long (maximum is 20 characters)")
  end
  it "is invalid with a same email" do
    admin_first = create(:same_email_admin)
    admin_second = build(:same_email_admin)
    admin_second.valid?
    expect(admin_second.errors[:email]).to include("has already been taken")
  end
end

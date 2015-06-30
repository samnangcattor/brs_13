require "rails_helper"

describe User do
  let(:user) {subject {FactoryGirl.create :user}}

  describe "#user" do
    it {is_expected.to be_an User}
  end

  describe "#name" do
    before {subject.name = nil}
    context "should invalid withouth name" do
      it {is_expected.to have(1).error_on(:name)}
    end
  end

  describe "#name" do
    context "should invalid when maximum length large than 50" do
      it {is_expected.to ensure_length_of(:name).is_at_most(50)}
    end
  end

  describe "#name" do
    before {@another_user = FactroyGirl.create :user}
    context "should be uniqueness" do
      it {is_expected.to have(1).error_on(:name)}
    end
  end

  describe "#email" do
    before {subject.email = nil}
    context "should invalid withouth email" do
      it {is_expected.to have(1).error_on(:email)}
    end
  end

  describe "#email" do
    before {@another_user = FactroyGirl.create :user}
    before {@another_user.name = "a"}
    before {@another_user.email = subject.email}
    context "should be uniqueness" do
      it {is_expected.to have(1).error_on(:email)}
    end
  end

  describe "#email" do
    context "should invalid when maximum length large than 50" do
      it {is_expected.to ensure_length_of(:email).is_at_most(50)}
    end
  end

  describe "#email" do
    before {subject.email = "samanng@gmail"}
    context "should invalid with wrong format" do
      it {is_expected.to have(1).error_on(:email)}
    end
  end

  describe "#email" do
    before {subject.email = "Dam.Sam.Nang@FramGia.Com"}
    context "should down-case after save" do
      it {expect(subject.email).to eq "dam.sam.nang@framgia.com"}
    end
  end
end

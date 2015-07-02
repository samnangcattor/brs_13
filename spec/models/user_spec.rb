require "rails_helper"

describe User do
  let(:user) {FactoryGirl.create :user}
  subject {FactoryGirl.create :user}

  describe "#user" do
    it {is_expected.to be_an User}
  end

  describe "#name" do
    before {subject.name = nil}
    before {subject.save}
    context "should invalid withouth name" do
      it {expect(subject.errors[:name].size).to eq 1}
    end
  end

  describe "#name" do
    before {subject.name = "abcdefhml" * 10}
    before {subject.save}
    context "should invalid when maximum length large than 50" do
      it {expect(subject.errors[:name].size).to eq 1}
    end
  end

  describe "#name" do
    before {@another_user = FactoryGirl.build :user}
    before {@another_user.name = subject.name}
    before {@another_user.save}
    context "should be uniqueness" do
      it {expect(@another_user.errors[:name].size).to eq 1}
    end
  end

  describe "#email" do
    before {subject.email = nil}
    before {subject.save}
    context "should invalid withouth email" do
      it {is_expected.to be_an User}
    end
  end

  describe "#email" do
    before {@another_user = FactoryGirl.create :user}
    before {@another_user.name = "a"}
    before {@another_user.email = subject.email}
    before {@another_user.save}
    context "should be uniqueness" do
      it {expect(@another_user.errors[:email].size).to eq 1}
    end
  end

  describe "#email" do
    before {subject.email = "Dam.Sam.Nang@FramGia.Com"}
    before {subject.save}
    context "should down-case after save" do
      it {expect(subject.email).to eq "dam.sam.nang@framgia.com"}
    end
  end

  describe "#Follow method" do
    before {@another_user = FactoryGirl.create :user}
    before {@another_user.save}

    describe ".follow" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:follow)}
      end

      context "method is work" do
        it {expect(subject.follow @another_user)}
      end
    end

    describe ".unfollow" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:unfollow)}
      end

      context "method is work" do
        before {subject.follow @another_user}
        it {expect(subject.unfollow @another_user)}
      end
    end

    describe ".following?" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:following)}
      end

      context "user is following other user" do
        before {subject.follow @another_user}
        it {expect(subject.following? @another_user)}
      end

      context "user is not following other user" do
        it {expect(subject.following? @another_user)}
      end
    end
  end

  describe "#Read method" do
    let(:book) {FactoryGirl.create :book}

    before {@book = FactoryGirl.create :book}

    describe ".reading" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:reading)}
      end

      context "method is work" do
        it {expect(subject.reading @book)}
      end
    end

    describe ".reading?" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:reading?)}
      end

      context "method is work" do
        before {subject.reading @book}
        it {expect(subject.reading? @book)}
      end
    end

    describe ".read?" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:read?)}
      end

      context "method is work" do
        before {subject.reading @book}
        it {expect(subject.read? @book)}
      end
    end
  end
end

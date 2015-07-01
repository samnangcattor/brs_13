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

  describe "#Read and Favorite method" do
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

    describe ".favourite" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:favourite)}
      end

      context "method is work" do
        before {subject.favourite @book}
        it {expect(subject.favourite @book)}
      end
    end

    describe ".unfavourite" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:unfavourite)}
      end

      context "method is work" do
        before {@book_state = subject.favourite @book}
        it {expect(subject.unfavourite @book_state)}
      end
    end

    describe ".favourite?" do
      context "method is presentation" do
        it {expect(subject).to respond_to(:favourite?)}
      end

      context "method is work" do
        before {subject.favourite @book}
        it {expect(subject.favourite? @book)}
      end
    end
  end

  describe "#Activity method" do
    let(:activity) {FactoryGirl.create :user_activity}

    before {@activity = FactoryGirl.create :activity}

    describe ".follow_activity?" do
      before {@another_user = FactoryGirl.create :user}
      before {@relationship = subject.follow @another_user}
      before {@activity.target_id = @relationship.id}
      before {@activity.state_target = "follow"}
      before {@activity.save}
      context "method is work" do 
        it {expect(subject.follow_activity? @activity)}
      end
    end

    describe ".read_activity?" do
      let(:book_state) {FactoryGirl.create :mark_book_state}

      before {@book_state = FactoryGirl.create :book_state}
      before {@book_state.state = "read"}
      before {@activity.target_id = @book_state.id}
      before {@activity.state_target = @book_state.state}
      context "method is work" do
        it {expect(subject.read_activity? @activity)}
      end
    end

    describe ".favorite_activity?" do
      let(:book_favorite) {FactoryGirl.create :mark_book_favorite}

      before {@book_favorite = FactoryGirl.create :book_favorite}
      before {@activity.target_id = @book_favorite.id}
      before {@activity.state_target = "favorite"}
      context "method is work" do
        it {expect(subject.favorite_activity? @activity)}
      end
    end

    describe ".find_followed" do
      before {@another_user = FactoryGirl.create :user}
      before {@relationship = subject.follow @another_user}
      before {@activity.target_id = @relationship.id}
      context "method is work" do
        it {expect(subject.find_followed @activity.target_id).to eq @another_user}
      end
    end

    describe ".find_read" do
      let(:book_state) {FactoryGirl.create :mark_book_state}

      before {@book = FactoryGirl.create :book}
      before {@book_state = FactoryGirl.create :book_state}
      before {@book_state.book_id = @book.id}
      before {@book_state.save}
      before {@book_state.state = "read"}
      before {@activity.target_id = @book_state.id}
      context "method is work" do
        it {expect(subject.find_read @activity.target_id).to eq @book}
      end
    end

    describe ".find_favorite" do
      let(:book_favorite) {FactoryGirl.create :mark_book_favorite}

      before {@book = FactoryGirl.create :book}
      before {@book_favorite = FactoryGirl.create :book_favorite}
      before {@book_favorite.book_id = @book.id}
      before {@book_favorite.save}
      before {@activity.target_id = @book_favorite.id}
      context "method is work" do
        it {expect(subject.find_favorite @activity.target_id).to eq @book}
      end
    end

    describe ".like" do
      context "method is work" do
        it {expect(subject.like @activity)}
      end
    end

    describe ".unlike" do
      before {subject.like @activity}
      context "method is work" do
        it {expect(subject.unlike @activity)}
      end
    end

    describe ".liking?" do
      before {subject.like @activity}
      context "method is work" do
        it {expect(subject.liking? @activity)}
      end
    end
  end
end

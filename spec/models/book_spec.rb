require "rails_helper"

describe Book do
  let(:book) {FactoryGirl.create :book}

  subject {FactoryGirl.create :book}
  
  describe "#book" do
    it {is_expected.to be_a Book}
  end 

  describe "#title" do
    before {subject.title = nil}
    before {subject.save}
    context "should invalid withouth name" do
      it {expect(subject.errors[:title].size).to eq 1}
    end
  end

  describe "#title" do
    before {subject.title = subject.title * 100}
    before {subject.save}
    context "should invalid long maxinus" do
      it {expect(subject.errors[:title].size).to eq 1}
    end
  end

  describe "#publish_date" do
    before {subject.publish_date = nil}
    before {subject.save}
    context "should invalid withouth publish date" do
      it {expect(subject.errors[:publish_date].size).to eq 1}
    end
  end

  describe "#page" do
    before {subject.page = nil}
    before {subject.save}
    context "should invalid withouth page" do
      it {expect(subject.errors[:page].size).to eq 2}
    end
  end

  describe "#page" do
    before {subject.page = true}
    before {subject.save}
    context "only number" do
     it {expect(subject.errors[:page].size).to eq 1} 
    end
  end 

  describe "#page" do
    before {subject.page = 2.2}
    before {subject.save}
    context "only integer" do
     it {expect(subject.errors[:page].size).to eq 1} 
    end
  end

  describe "#page" do
    before {subject.page = -1}
    before {subject.save}
    context "greater than 0" do
     it {expect(subject.errors[:page].size).to eq 1} 
    end
  end

  describe "#reviews" do
    let(:review) {FactoryGirl.create :review_book}

    before {@review = FactoryGirl.create :review}
    before {subject.reviews << @review}
    before {subject.destroy}
    context "ActiveRecord associations" do
      it {expect(Review.all).not_to include @review}
    end
  end

  describe "#book_states" do
    let(:book_state) {FactoryGirl.create :mark_book_state}

    before {@book_state = FactoryGirl.create :book_state}
    before {subject.book_states << @book_state}
    before {subject.destroy}
    context "ActiveRecord associations" do
      it {expect(BookState.all).not_to include @book_state}
    end
  end

  describe "#autor_books" do
    let(:author_book) {FactoryGirl.create :author_of_book}

    before {@author_book = FactoryGirl.create :author_book}
    before {subject.author_books << @author_book}
    before {subject.destroy}
    context "ActiveRecord associations" do
      it {expect(AuthorBook.all).not_to include @author_book}
    end
  end
end

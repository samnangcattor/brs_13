class ReviewsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform book_id
    reviewss = Book.find(book_id).reviews
    last_user = reviewss.last.user
    reviewss.each do |review|
      UserMailer.review_email_contact(review, last_user).deliver_now
    end
  end
end

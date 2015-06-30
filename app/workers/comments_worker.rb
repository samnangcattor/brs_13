class CommentsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform comment_id
    comment = Comment.find comment_id
    UserMailer.comment_email_contact(comment).deliver_now
  end
end

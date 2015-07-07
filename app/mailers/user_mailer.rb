class UserMailer < ApplicationMailer
  def review_email_contact review, last_user
    @user_name = review.user.name
    @user_email = review.user.email
    @last_user = last_user
    mail to: @user_email, suject: t("emails.review")
  end
  
  def comment_email_contact comment
    @name_comment = comment.user.name
    @comment_body = comment.comment
    @email_review = comment.review.user.email
    @name_review = comment.review.user.name
    mail to: @email_review, suject: t("emails.review")
  end

  def accepting_book user, request_book
    @user = user
    @request_book = request_book
    mail to: @user.email, subject: t("emails.acceptbook")
  end
end

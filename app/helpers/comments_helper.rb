module CommentsHelper
  def comment_author(comment)
    if comment.user.nil?
      'anonymous'
    else
      comment.user.username
    end
  end
end
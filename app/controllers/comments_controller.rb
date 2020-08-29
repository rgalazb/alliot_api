class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.valid?
      comment.save!
      render json: {id: comment.id, author: comment.user.email, content: comment.content}
    else
      render json: comment.errors.full_messages, status: 422
    end
  end

  private
    def comment_params
      JSON.parse(params.require(:comment), object_class: ActionController::Parameters).permit(:content, :request_id)
    end
end

class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    requests = Request.preload(:user, :comments, :reactions, comments: [:user])
    response = requests.map do |r|
      set_response r
    end
    render json: response
  end

  def create
    request = Request.new(request_params)
    request.user_id = current_user.id
    if request.valid?
      request.save!
      render json: set_response(request)
    else
      render json: requests.errors.full_messages, status: 422
    end
  end

  private
    def request_params
      JSON.parse(params.require(:request), object_class: ActionController::Parameters).permit(:title, :description)
    end

    def set_response request
      {
        id: request.id,
        title: request.title,
        description: request.description,
        likes: request.reactions.select {|r| r.like?}.count,
        dislikes: request.reactions.select {|r| r.dislike?}.count,
        author: request.user.email,
        comments: request.comments.map {|c| {id: c.id, author: c.user.email, content: c.content}}
      }
    end
end

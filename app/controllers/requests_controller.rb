class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    requests = Request.preload(:user, :comments, comments: [:user])
    response = requests.map do |r|
      {
        id: r.id,
        title: r.title,
        description: r.description,
        author: r.user.email,
        comments: r.comments.map {|c| {id: c.id, author: c.user.email, content: c.content}}
      }
    end
    render json: response
  end
end

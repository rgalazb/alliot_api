class ReactionsController < ApplicationController
  before_action :authenticate_user!

  def create
    reaction = Reaction.new(reaction_params)
    reaction.user_id = current_user.id
    if reaction.valid?
      reaction.save!
      render json: {id: reaction.id, author: reaction.user.email, kind: reaction.kind, request_id: reaction.request_id}
    else
      render json: reaction.errors.full_messages, status: 422
    end
  end

  private
    def reaction_params
      JSON.parse(params.require(:reaction), object_class: ActionController::Parameters).permit(:kind, :request_id)
    end
end

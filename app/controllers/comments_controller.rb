class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = set_commentable
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment posted successfully.'
    else
      flash[:alert] = 'Sorry, there was an issue with saving that comment.'
    end

    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
    return unless @comment.user == current_user

    if @comment.comments.present?
      return
    else
      @comment.destroy
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def create_pair
    ingredient1 = Ingredient.find(params[:comment][:ingredient1_id].to_i)
    ingredient2 = Ingredient.find(params[:comment][:ingredient2_id].to_i)

    Pair.create(ingredient1: ingredient1, ingredient2: ingredient2)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    input = params[:comment]

    return Comment.find(input[:comment_id]) if input[:comment_id]
    return Pair.find(input[:pair_id].to_i) if input[:pair_id]
    return create_pair if input[:ingredient1_id]

    nil
  end
end

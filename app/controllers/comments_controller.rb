class CommentsController < ApplicationController
  before_action :set_commentable, only: :create

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment posted successfully.'
    else
      flash[:alert] = 'Sorry, there was an issue with saving that comment.'
    end

    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_commentable
    if params[:comment][:comment_id]
      @commentable = Comment.find(params[:comment][:comment_id])
    elsif params[:comment][:pair_id]
      @commentable = Pair.find(params[:comment][:pair_id].to_i)
    elsif params[:comment][:ingredient1_id]
      ingredient1 = Ingredient.find(params[:comment][:ingredient1_id].to_i)
      ingredient2 = Ingredient.find(params[:comment][:ingredient2_id].to_i)

      @commentable = Pair.create(ingredient1: ingredient1, ingredient2: ingredient2)
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

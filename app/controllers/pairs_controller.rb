class PairsController < ApplicationController
  def index
    redirect_to_show_or_new if params[:ing1]
  end

  def show
    @pair ||= Pair.find(params[:id])
  end

  def new
  end

  private

  def redirect_to_show_or_new
    ingredients = [params[:ing1], params[:ing2]].sort
    @pair = Pair.find("#{ingredients[0]}-#{ingredients[1]}")

    redirect_to @pair and return if @pair

    redirect_to action: 'new'
  end
end

class PairsController < ApplicationController
  def index
    redirect_to_show_or_new if params[:ing1]
  end

  def show
    @pair = Pair.find(params[:id])
    @ingredient1 = @pair.ingredient1
    @ingredient2 = @pair.ingredient2
  end

  def new
  end

  private

  def redirect_to_show_or_new
    @ingredients = [params[:ing1], params[:ing2]].sort

    @pair = Pair.find("#{@ingredients[0]}-#{@ingredients[1]}")
    @ingredient1 = Ingredient.find(@ingredients[0])
    @ingredient2 = Ingredient.find(@ingredients[1])

    render 'show' and return if @pair

    render 'new'
  end
end

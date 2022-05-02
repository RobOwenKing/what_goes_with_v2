class IngredientsController < ApplicationController
  before_action :redirect_non_admins, only: %i[new create]

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :slug, :aka, :eg)
  end

  def redirect_non_admins
    redirect_to root_path unless current_user.admin?
  end
end

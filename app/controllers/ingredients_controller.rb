class IngredientsController < ApplicationController
  before_action :redirect_non_admins, except: %i[index show]
  before_action :set_ingredient, only: %i[show edit update delete]

  def index
    if params[:q].present?
      sql_query = 'name ILIKE :query OR aka ILIKE :query OR eg ILIKE :query'
      @ingredients = Ingredient.where(sql_query, query: "%#{params[:q]}%")
                               .order(:name)
    else
      @ingredients = Ingredient.order(:name)
    end

    respond_to do |format|
      format.json { render json: @ingredients }
      format.html # Fallback in case they have JS blocked
    end
  end

  def show
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
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient)
    else
      render :edit
    end
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

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end

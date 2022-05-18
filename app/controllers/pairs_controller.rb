class PairsController < ApplicationController
  def show
    @pair = Pair.find(params[:id])
  end

  def new
  end
end

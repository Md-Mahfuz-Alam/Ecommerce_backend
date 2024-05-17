class Api::V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    categories=Category.all
    render json: categories
  end

  def show
    render json: @category
  end

  def create
    category=Category.new(category_params)
    if category.save!
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end 
  end

  def destroy
    @category.destroy
  end

  private 
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category=Category.find(params[:id])
  end
end

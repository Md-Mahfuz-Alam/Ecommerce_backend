class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :update, :destroy]


  def index
    @products=Product.all
    if params[:include]
      includes=params[:include].split(",")
      @products=include_associated_data(@products,includes)
    end
    render json: @products, include: includes 
  end

  def create
    @product=Product.new(product_params)
    @product.images
    if @product.save!
        render json: @product, status: :created
    else
        render json: @product.error, status: :unprocessable_entity
    end
  end

  def show
   render json: @product
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end 
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name,:description,:price,:quantity_available,:seller_id,:category_id,images: [])
  end

  def set_product
    @product=Product.find(params[:id])
  end

  def include_associated_data(products, includes)
    includes.each do |include_param|
      case include_param
      when 'category'
        @products=products.includes(:category)
      when 'seller'
        @products=products.includes(:seller)
      when 'images'
        products = products.includes(images_attachments: :blob)
     end
    end
    @products
  end

end
class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_seller, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin, only: [:index]
  before_action only: [:edit, :update, :destroy] do
    seller_owns_this_product?(@product)
  end


  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.xml { render xml: @products.to_xml }
      format.yaml { render text: @products.to_yaml }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end

    # Restrict sellers to manage only their own products
    def seller_owns_this_product?(product)
      # TODO: store the associated user's seller_id into sesssion to avoid same query for each req
      current_seller = Seller.find_by(user_id: session[:user_id]) if session[:user_id]
      redirect_to store_url unless current_seller.user_id == product.seller_id
    end
end

class ProductsController < ApplicationController


  before_action :set_product, only: %i[ show edit update destroy remove_image ]

  # GET /products or /products.json
  def index
  @categories = Category.order(:order, :name)

  if params[:category_id].present?
    @active_category = @categories.find_by(id: params[:category_id])
    @products = @active_category ? @active_category.products.order(:name) : Product.none
  else
    @active_category = nil
    @products = Product.order(:name)   # show all products by default
  end

  @latest_products = Product.order(created_at: :desc).limit(5)
end


  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
  respond_to do |format|
    if params[:product][:images].present?
      # Attach new images without replacing existing ones
      @product.images.attach(params[:product][:images])
      if @product.update(product_params.except(:images))
        format.html { redirect_to edit_product_path(@product), notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    else
      if @product.update(product_params)
        format.html { redirect_to edit_product_path(@product), notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
end


  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def remove_image
    image = @product.images.find(params[:image_id])
    image.purge
    redirect_back fallback_location: @product, notice: "Image removed"
  end

  def reorder_images
  @product = Product.find(params[:id])

  params[:order].each_with_index do |image_id, index|
    attachment = @product.images.attachments.find(image_id)
    attachment.update(position: index)
  end

  head :ok
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :slug, :price, :uploaded_at, :quantity, :condition, :category_id, :status, images: [] ])
    end
end

class ProductsController < InheritedResources::Base
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	before_action :initialize_cart

	def index
		@products = Product.includes(:image_groups).all
	end

	def show
		@image = @product.image_groups.first.image
	end

	def new
		@product = Product.new
		@image_group = @product.image_groups.new
	end

	def edit
	end

	def create
		@product = Product.new(product_params)

		respond_to do |format|
			if @product.save
				format.html { redirect_to @product, notice: "Your product was successfully created!" }
				format.json { render :show, status: :created, location: @product }
			end
			  format.html { render :new }
			  format.json { render json: @product.errors, status: :unprocessable_entity }
		end
	end

	def update
		respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
	end

  private

    def set_product
  		@product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :active, image_groups_attributes: [:image])
    end
end


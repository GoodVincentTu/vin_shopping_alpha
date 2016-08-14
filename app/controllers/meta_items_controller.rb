class MetaItemsController < InheritedResources::Base
  before_action :set_meta_item, only: [:show, :edit, :update, :destroy]

  def index
  	@meta_items = MetaItem.all
  end

  def show
  	@products = @meta_item.products
  end

  def new
  	@meta_item = MetaItem.new
  end

  def edit
  end

  def create
  	@meta_item = MetaItem.new(meta_item_params)

  	respond_to do |format|
  		if @meta_item.save
  			format.html { redirect_to @meta_item, notice: "Categories was successfully created!" }
  			format.json { render :show, status: :created, location: @meta_item }
  		else
  			format.html { render new }
  			format.json { render json: @meta_item.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def update
  	respond_to do |format|
  		if @meta_item.update(meta_item_params)
  			format.html { redirect_to @meta_item, notice: "Categories was successfully updated!" }
  			format.json { render :show, status: :ok, location: @meta_item }
  		else
  			format.html { render :edit }
  			format.json { render json: @meta_item.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def destroy
  	@meta_item.destroy
  	respond_to do |format|
  		format.html { redirect_to meta_items_url, notice: "Category was successfully destroyed!" }
  		format.json { head :no_content }
  	end
  end

  private
  	def set_meta_item
  		@meta_item = MetaItem.includes(:products).find(params[:id])
  	end

    def meta_item_params
      params.require(:meta_item).permit(:name, :sku, :price)
    end
end


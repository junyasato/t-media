class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @new_items = Item.create(item_params)
    @articles = Article.find_by_id(item_params[:article_id])
    @articles.item_order << "," + @new_items.id.to_s if @articles.item_order
    @articles.item_order = @new_items.id.to_s unless @articles.item_order
    @articles.save
    if @articles.item_order.present?
      item_order = @articles.item_order.split(",")
    else
      item_order = @articles.item_order = @new_items.id.to_s
    end
    @items = @articles.items.where(id: item_order).order(['field(id, ?)', item_order])
  end

  def edit
    @items = Item.find_by_id(params[:id])
  end

  def update
    @items = Item.find_by_id(params[:id])
    @items.update(item_params)
    respond_to do |format|
      format.js { render :action => 'update' }
    end
  end

  def destroy
    @items = Item.find_by_id(params[:id])
    @items.destroy
  end

  private

  def item_params
    params[:item].permit(
      :desc,
      :item_type,
      :article_id,
      :title,
      :link_url,
      :image,
      :remote_image_url
    )
  end
end

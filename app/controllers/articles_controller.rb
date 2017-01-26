class ArticlesController < ApplicationController
  before_action :set_articles, only: [
    :edit,
    :update,
    :destroy,
    :save,
    :show
  ]

  def index
  end

  def show
    @title           = @articles.title
    @desc            = @articles.desc
    @article_ranking = Article.limit(5)
    @related_article = Article.limit(3)

    @items = @articles.items
    if @items.present?
      item_order = @articles.item_order.split(",") if @articles.item_order
      @items = @articles.items.where(id: item_order).order(['field(id, ?)', item_order])
    end
  end

  def new
    @articles = Article.create
    redirect_to edit_article_path(@articles)
  end

  def edit
    @items = @articles.items.order("id desc")
    if @items.present?
      item_order = @articles.item_order.split(",") if @articles.item_order
      @items = @articles.items.where(id: item_order).order(['field(id, ?)', item_order])
    end
  end

  def create
  end

  def update
    @articles.update(article_params)
    redirect_to edit_article_path(@articles)
  end

  def destroy
  end

  def save
    @articles.update(item_order: params[:item_order])
    redirect_to edit_article_path(@articles.id)
  end

  def add_text
    @article_id = params[:id]
    @items = Item.new(item_type: "text")
  end

  def add_header
    @article_id = params[:id]
    @items = Item.new(item_type: "header")
  end

  def add_quote
    @article_id = params[:id]
    @items = Item.new(item_type: "quote")
  end

  def add_button
    @article_id = params[:id]
    @items = Item.new(item_type: "button")
  end

  def add_image
    @article_id = params[:id]
    @items = Item.new(item_type: "image")
  end

  private

  def set_articles
    @articles = Article.find(params[:id])
  end

  def article_params
    params[:article].permit(
      :title,
      :desc,
      :item_order,
      :image,
      :remote_image_url
    )
  end
end

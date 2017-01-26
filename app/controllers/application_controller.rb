class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_category

  def get_category
    @category = Category.all
  end
end

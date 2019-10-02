class StaticPagesController < ApplicationController
  before_action :page, only: %i(index)
  load_and_authorize_resource

  def index
    @supports = Support.new page: page, per_page: Settings.nine
    @popular_products = Product.most_bought self
  end

  private

  def page
    params[:page]
  end
end

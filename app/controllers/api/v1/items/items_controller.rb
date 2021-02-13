class Api::V1::Items::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
end

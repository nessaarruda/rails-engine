class Api::V1::Items::ItemsController < ApplicationController

  def index
    items = Item.limit(params[:limit])
    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
end

class Api::V1::Items::ItemsController < ApplicationController
  def index
    items = Item.limit(params[:limit])
    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end

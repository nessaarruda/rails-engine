class Api::V1::Items::ItemsController < ApplicationController
  def index
    if params[:per_page]
      item = Item.pagination(params[:per_page], params[:page])
      render json: ItemSerializer.new(item)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end

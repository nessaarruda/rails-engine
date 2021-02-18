class Api::V1::Items::ItemsController < ApplicationController
  def index
    item = Item.pagination(params[:per_page], params[:page])
    render json: ItemSerializer.new(item)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    begin
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item), status: 202
    rescue
      render json: { "error" => {} }, status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end

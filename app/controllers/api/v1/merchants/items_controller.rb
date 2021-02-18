class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    begin
      merchant = Merchant.find(params[:id])
      items = merchant.items
      render json: ItemSerializer.new(items)
    rescue
      render json: { "error" => {} }, status: 404
    end
  end
end

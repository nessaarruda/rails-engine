class Api::V1::Items::MerchantsController < ApplicationController
  def show
    item = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(item)
  end
end

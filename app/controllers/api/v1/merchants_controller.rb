class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end

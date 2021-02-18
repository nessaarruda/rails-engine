class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.pagination(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end

class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:per_page]
      merchants = Merchant.pagination(params[:per_page], params[:page])
      render json: MerchantSerializer.new(merchants)
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end

class Api::V1::Merchants::FindController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(merchant_params))
  end

  private

  def merchant_params
    params.permit(:name)
  end
end

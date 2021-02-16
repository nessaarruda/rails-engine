class Api::V1::Merchants::SearchController < ApplicationController
  def find_merchant
    render json: MerchantSerializer.new(Merchant.search_one(attribute, value))
  end

  private

  def find_params
    params.permit(:name)
  end

  def attribute
    find_params.keys[0]
  end

  def value
    find_params[attribute]
  end
end

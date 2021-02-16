class Api::V1::Merchants::SearchController < ApplicationController

  def find_merchant
    render json: MerchantSerializer.new(Merchant.search_one(attribute, value))
  end
end

class Api::V1::Merchants::SearchController < ApplicationController
  def find_merchant
    merchant = Merchant.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
    render json: MerchantSerializer.new(merchant.first)
  end

  def most_items
    merchants = Merchant.items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end

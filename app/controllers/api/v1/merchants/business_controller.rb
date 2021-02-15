class Api::V1::Merchants::BusinessController < ApplicationController

  def most_revenue
    merchants = Merchant.top_revenue(params[:quantity])
    render json: BusinessSerializer.new(merchants)
  end

  def total_revenue
    merchant = Merchant.find(params[:id]).total_revenue
    render json: BusinessSerializer.new(merchant)
  end
end

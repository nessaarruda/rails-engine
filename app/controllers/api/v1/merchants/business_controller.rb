class Api::V1::Merchants::BusinessController < ApplicationController
  def most_revenue
    merchants = Merchant.top_revenue(params[:quantity])
    render json: BusinessSerializer.new(merchants)
  end

  def total_revenue
    merchant = Merchant.find(params[:id]).revenue
    render json: BusinessSerializer.new(merchant)
  end

  def items_sold
    merchants = Merchant.items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def revenue_date_range
    merchants = Merchant.date_revenue(params[:start], params[:end])
    render json: BusinessSerializer.new(merchants)
  end
end

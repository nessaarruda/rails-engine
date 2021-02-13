class Api::V1::Merchants::BusinessController < ApplicationController

  def most_revenue
    merchants = Merchant.top_revenue(params[:quantity])
    render json: BusinessSerializer.new(merchants)
  end
end

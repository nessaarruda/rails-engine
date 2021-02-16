class Api::V1::Items::SearchController < ApplicationController

  def find_items
    render json: ItemSerializer.new(Item.find_all_items(attribute, value))
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

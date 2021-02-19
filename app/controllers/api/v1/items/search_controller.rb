class Api::V1::Items::SearchController < ApplicationController
  def find_items
    item = Item.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
    render json: ItemSerializer.new(item)
    #return 0 if nothing found
  end
end

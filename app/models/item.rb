class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.find_all_items(attribute, value)
    Item.where("LOWER(#{attribute}) LIKE LOWER('%#{value}%')")
  end
end

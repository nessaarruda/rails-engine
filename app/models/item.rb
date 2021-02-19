class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.pagination(per_page, page)
     num_limit = (per_page || 20).to_i
     skipped_pages = (page || 1).to_i - 1 # default is 1, subtract 1 to get the pages you need to skip
     limit(num_limit).offset(num_limit * skipped_pages)
  end
end

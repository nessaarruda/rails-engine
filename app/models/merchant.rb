class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  validates :name, presence: true
end

class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.top_revenue(limit)
    x = joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .group('merchants.id')
    .order('total_revenue DESC')
    .limit(limit)
    require "pry"; binding.pry
  end
end

class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.top_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
    .where('result = ?', 'success')
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group(:id)
    .order('total_revenue DESC')
    .limit(limit)
  end

  def total_revenue
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped', merchant_id: self.id})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.date_revenue(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .where(invoices: {created_at: start_date..end_date})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end

class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.pagination(per_page, page)
     num_limit = (per_page || 20).to_i
     skipped_pages = (page || 1).to_i - 1 # default is 1, subtract 1 to get the pages you need to skip
     limit(num_limit).offset(num_limit * skipped_pages)
  end

  def self.top_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group(:id)
    .order('total_revenue DESC')
    .limit(limit)
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
            .where(transactions: { result: 'success' }, invoices: { status: 'shipped', merchant_id: id })
            .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.items(limit)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .select('merchants.id, merchants.name, sum(invoice_items.quantity) AS items_sold')
      .group('merchants.id')
      .order('items_sold DESC')
      .limit(limit)
  end

  def self.date_revenue(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .where(invoices: { created_at: start_date..end_date })
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end

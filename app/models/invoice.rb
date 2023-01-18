class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_after_discounts 
    invoice_items.sum do |ii|
      total = ii.unit_price * ii.quantity
      if ii.find_discount.nil?
        total
      else
        total * (100 - ii.find_discount.discount.to_f) / 100
      end
    end
  end
end

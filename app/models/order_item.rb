class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  def line_total
    quantity * price
  end
end

module OrdersHelper
  def amount(cost)
    number_to_currency(cost)
  end
end

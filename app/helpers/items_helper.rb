module ItemsHelper
  def formatted_price(price)
    "¥#{number_with_delimiter(price)}"
  end

  def item_count(items)
    "#{number_with_delimiter(items.count)}点"
  end

  def total_price(items)
    "¥#{number_with_delimiter(items.sum(:price))}"
  end
end

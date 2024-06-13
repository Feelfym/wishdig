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

  def display_heading
    if @is_filtered
      if @items.present?
        "#{@selected_year}年#{@selected_month}月の購入予定アイテム: #{formatted_price(@total)}"
      else
        "#{@selected_year}年#{@selected_month}月の購入予定アイテムはありません。"
      end
    else
      if @items.present?
        "購入予定アイテムの総額 (全期間): #{formatted_price(@total)}"
      else
        "#{@user.name}さんのほしいものリストはまだ空です。"
      end
    end
  end  
end

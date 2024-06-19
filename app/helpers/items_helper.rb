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

  def display_heading(list_name)
    if filtered?
      if @items.present?
        "#{@selected_year}年#{@selected_month}月の#{list_name}: #{formatted_price(@total)}"
      else
        "#{@selected_year}年#{@selected_month}月の#{list_name}はありません。"
      end
    else
      if @items.present?
        "#{list_name}の総額 (全期間): #{formatted_price(@total)}"
      else
        "#{@user.name}さんの#{list_name}はまだ空です。"
      end
    end
  end

  def items_table(items, current_user, table_name)
    return unless items.present?
  
    column_name = table_column_name(table_name) #プライベートメソッドで定義
    content_tag :table, class: 'table table-hover mt-5' do
      concat table_header(column_name) #プライベートメソッドで定義
      concat table_body(items, current_user) #プライベートメソッドで定義
    end
  end
  
  
  def item_image(item)
    if item.image.attached?
      item.image
    else
      "noimage.jpg"
    end
  end
  
  def item_date(item)
    item.purchased_flag? ? item.purchased_date : item.will_purchase_date
  end
  
  def item_url(item)
    item.url.present? ? link_to("商品ページ", item.url, target: "_blank", class: "btn btn-outline-info btn-sm item-link") : ""
  end
  
  def purchase_link(item)
    if item.purchased_flag?
      link_to "未購入に戻す", purchase_item_path(item), class: "btn btn-outline-secondary btn-sm item-link mr-2", data: { turbo_method: :patch, turbo_confirm: "未購入に戻しますか？" }
    else
      link_to "購入済みにする", purchase_item_path(item), class: "btn btn-outline-secondary btn-sm item-link mr-2", data: { turbo_method: :patch, turbo_confirm: "購入済みにしますか？" }
    end
  end

  private

  def filtered?
    @selected_year.present? && @selected_month.present?
  end

  def table_column_name(table_name)
    case table_name
    when '購入済み'
      '購入日'
    when 'ほしいもの'
      '購入予定日'
    else
      '日付'
    end
  end

  def table_header(column_name)
    content_tag(:thead, class: 'thead-light') do
      content_tag(:tr) do
        ['', 'アイテム名', '価格', column_name, 'URL', '操作'].each do |header|
          concat content_tag(:th, header)
        end
      end
    end
  end
  
  
  def table_body(items, current_user)
    content_tag(:tbody) do
      items.each do |item|
        concat(render partial: 'item', locals: { item: item }) if item.user_id == current_user.id
      end
    end
  end
end

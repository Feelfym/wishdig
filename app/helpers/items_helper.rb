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

    if table_name == '購入済み'
      column_name = '購入日'
    elsif table_name == 'ほしいもの'
      column_name = '購入予定日'
    else
      column_name = '日付'
    end

    content_tag :table, class: 'table table-hover mt-5' do
      concat(
        content_tag(:thead, class: 'table-light') do
          content_tag(:tr) do
            concat content_tag(:th, 'アイテム名')
            concat content_tag(:th, '価格')
            concat content_tag(:th, column_name)
            concat content_tag(:th, 'URL')
            concat content_tag(:th, '操作')
          end
        end
      )
      concat(
        content_tag(:tbody) do
          items.each do |item|
            concat(render partial: 'item', locals: { item: item }) if item.user_id == current_user.id
          end
        end
      )
    end
  end

  private

  def filtered?
    @selected_year.present? && @selected_month.present?
  end

end

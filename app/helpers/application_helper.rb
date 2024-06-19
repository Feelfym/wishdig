module ApplicationHelper
  def year_select(selected_year)
    options = content_tag(:option, '-- 選択してください --', value: '')
    (2024..Date.today.year+3).each do |year|
      options += content_tag(:option, "#{year}年", value: year, selected: year == selected_year)
    end
    select_tag 'selected_year', options, id: 'selected_year', class: 'form-control'
  end

  def month_select(selected_month)
    options = content_tag(:option, '-- 選択してください --', value: '')
    (1..12).each do |month|
      options += content_tag(:option, "#{month}月", value: month, selected: month == selected_month)
    end
    select_tag 'selected_month', options, id: 'selected_month', class: 'form-control'
  end
end

module Public::PostsHelper
  def determine_category_color(category_name)
    case category_name
    when 'Goods' then '#fff27b' # カテゴリがGoodsの場合の色
    when 'Action' then '#ffc3c3' # カテゴリがActionの場合の色
    else '#cccccc' # それ以外の場合の色
    end
  end
end

module ApplicationHelper
  CURRENCY_SYMBOLS = {
    "USD" => "$",
    "EUR" => "€",
    "GBP" => "£",
    "JPY" => "¥",
    "CNY" => "¥"
  }.freeze

  CATEGORY_ICONS = {
    "food"          => "bi-cup-hot",
    "transport"     => "bi-train-front",
    "shopping"      => "bi-bag",
    "health"        => "bi-heart-pulse",
    "entertainment" => "bi-controller",
    "housing"       => "bi-house",
    "other"         => "bi-three-dots"
  }.freeze

  def category_icon(category)
    CATEGORY_ICONS[category.to_s] || "bi-three-dots"
  end

  def format_currency(amount)
    symbol = CURRENCY_SYMBOLS[current_user.currency] || current_user.currency
    number_to_currency(amount, unit: symbol, format: "%u %n", precision: 0, delimiter: ".")
  end
end

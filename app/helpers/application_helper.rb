module ApplicationHelper
  CURRENCY_SYMBOLS = {
    "USD" => "$",
    "EUR" => "€",
    "GBP" => "£",
    "JPY" => "¥",
    "CNY" => "¥"
  }.freeze

  def format_currency(amount)
    symbol = CURRENCY_SYMBOLS[current_user.currency] || current_user.currency
    number_to_currency(amount, unit: symbol, format: "%u %n", precision: 0, delimiter: ".")
  end
end

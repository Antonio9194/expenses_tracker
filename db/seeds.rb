Subscription.destroy_all
Expense.destroy_all
MonthlySnapshot.destroy_all
Budget.destroy_all
User.destroy_all

admin = User.create!(
  email: "anto.vinciguerra@hotmail.com",
  password: "Marvelous9194",
  role: :admin
)

user = User.create!(
  email: "sophie@chatgpt.com",
  password: "iamsophie",
  role: :user
)

expenses = [
  # Food / convenience stores
  { title: "Tobu Food",        amount: 1645,  category: :food,          date: "2026-04-01" },
  { title: "Tobu Market",      amount: 2717,  category: :food,          date: "2026-04-01" },
  { title: "Starbucks",        amount: 720,   category: :food,          date: "2026-04-02" },
  { title: "Lunch",            amount: 1460,  category: :food,          date: "2026-04-02" },
  { title: "Lawson",           amount: 693,   category: :food,          date: "2026-04-03" },
  { title: "Dinner",           amount: 8690,  category: :food,          date: "2026-04-03" },
  { title: "7/11",             amount: 619,   category: :food,          date: "2026-04-04" },
  { title: "7/11",             amount: 399,   category: :food,          date: "2026-04-04" },
  { title: "Lunch",            amount: 3201,  category: :food,          date: "2026-04-05" },
  { title: "Supermarket",      amount: 1639,  category: :food,          date: "2026-04-05" },
  { title: "7/11",             amount: 881,   category: :food,          date: "2026-04-07" },
  { title: "Starbucks",        amount: 418,   category: :food,          date: "2026-04-08" },
  { title: "Dinner",           amount: 1180,  category: :food,          date: "2026-04-09" },
  { title: "Coffee",           amount: 940,   category: :food,          date: "2026-04-10" },
  { title: "Lawson",           amount: 2233,  category: :food,          date: "2026-04-11" },
  { title: "7/11",             amount: 1358,  category: :food,          date: "2026-04-11" },
  { title: "7/11",             amount: 1632,  category: :food,          date: "2026-04-12" },
  { title: "7/11",             amount: 2098,  category: :food,          date: "2026-04-13" },
  { title: "Dinner",           amount: 3500,  category: :food,          date: "2026-04-13" },
  { title: "Lunch",            amount: 1410,  category: :food,          date: "2026-04-14" },
  { title: "Starbucks",        amount: 720,   category: :food,          date: "2026-04-14" },
  { title: "Lawson",           amount: 193,   category: :food,          date: "2026-04-15" },
  { title: "Lawson",           amount: 195,   category: :food,          date: "2026-04-15" },
  { title: "Lunch",            amount: 1770,  category: :food,          date: "2026-04-16" },
  { title: "Starbucks",        amount: 911,   category: :food,          date: "2026-04-16" },
  { title: "Family Mart",      amount: 1056,  category: :food,          date: "2026-04-17" },
  { title: "7/11",             amount: 324,   category: :food,          date: "2026-04-17" },
  { title: "Lunch",            amount: 3380,  category: :food,          date: "2026-04-18" },
  { title: "7/11",             amount: 235,   category: :food,          date: "2026-04-19" },
  { title: "7/11",             amount: 1593,  category: :food,          date: "2026-04-19" },
  { title: "Lunch",            amount: 3420,  category: :food,          date: "2026-04-20" },
  { title: "7/11",             amount: 1493,  category: :food,          date: "2026-04-21" },
  { title: "Dinner",           amount: 2388,  category: :food,          date: "2026-04-21" },
  { title: "7/11",             amount: 1564,  category: :food,          date: "2026-04-22" },
  { title: "Coffee",           amount: 360,   category: :food,          date: "2026-04-22" },
  { title: "Coffee",           amount: 360,   category: :food,          date: "2026-04-22" },
  { title: "Dinner",           amount: 6000,  category: :food,          date: "2026-04-23" },
  { title: "Family Mart",      amount: 744,   category: :food,          date: "2026-04-24" },
  { title: "7/11",             amount: 630,   category: :food,          date: "2026-04-25" },
  { title: "Coffee",           amount: 1626,  category: :food,          date: "2026-04-25" },
  { title: "Family Mart",      amount: 118,   category: :food,          date: "2026-04-26" },
  { title: "Family Mart",      amount: 172,   category: :food,          date: "2026-04-26" },
  { title: "Pizza",            amount: 3289,  category: :food,          date: "2026-04-27" },
  { title: "7/11",             amount: 1646,  category: :food,          date: "2026-04-28" },
  { title: "Sake",             amount: 1130,  category: :food,          date: "2026-04-29" },
  { title: "7/11",             amount: 1606,  category: :food,          date: "2026-04-29" },

  # Health
  { title: "Medicine",         amount: 1180,  category: :health,        date: "2026-04-02" },
  { title: "Medicine",         amount: 4952,  category: :health,        date: "2026-04-03" },
  { title: "Dentist",          amount: 2570,  category: :health,        date: "2026-04-21" },

  # Transport
  { title: "Suica Charge",     amount: 1000,  category: :transport,     date: "2026-04-03" },
  { title: "Suica Charge",     amount: 1000,  category: :transport,     date: "2026-04-06" },
  { title: "Suica Charge",     amount: 1000,  category: :transport,     date: "2026-04-10" },
  { title: "Suica Charge",     amount: 2000,  category: :transport,     date: "2026-04-13" },
  { title: "Suica Charge",     amount: 2000,  category: :transport,     date: "2026-04-24" },
  { title: "Suica Charge",     amount: 2000,  category: :transport,     date: "2026-04-28" },
  { title: "Parking",          amount: 325,   category: :transport,     date: "2026-04-18" },
  { title: "Parking",          amount: 1000,  category: :transport,     date: "2026-04-28" },

  # Shopping
  { title: "Shopping",         amount: 1100,  category: :shopping,      date: "2026-04-08" },
  { title: "Amazon",           amount: 3183,  category: :shopping,      date: "2026-04-09" },
  { title: "Amazon",           amount: 1960,  category: :shopping,      date: "2026-04-09" },
  { title: "Amazon",           amount: 1160,  category: :shopping,      date: "2026-04-10" },
  { title: "Amazon",           amount: 2359,  category: :shopping,      date: "2026-04-12" },
  { title: "Amazon",           amount: 2966,  category: :shopping,      date: "2026-04-20" },
  { title: "Amazon",           amount: 3697,  category: :shopping,      date: "2026-04-29" },
  { title: "Amazon",           amount: 21165, category: :shopping,      date: "2026-04-27" },

  # Entertainment
  { title: "Karaoke",          amount: 6000,  category: :entertainment, date: "2026-04-23" }
]

expenses.each do |attrs|
  admin.expenses.create!(attrs)
end

subscriptions = [
  # Monthly — active
  { title: "Netflix",        amount: 1490,  billing_cycle: :monthly, status: :active,    start_date: "2024-01-01" },
  { title: "Spotify",        amount: 980,   billing_cycle: :monthly, status: :active,    start_date: "2023-06-15" },
  { title: "iCloud+",        amount: 1300,  billing_cycle: :monthly, status: :active,    start_date: "2022-09-01" },
  { title: "ChatGPT Plus",   amount: 2970,  billing_cycle: :monthly, status: :active,    start_date: "2025-03-10" },
  # Monthly — paused / cancelled
  { title: "Disney+",        amount: 990,   billing_cycle: :monthly, status: :paused,    start_date: "2023-11-01" },
  { title: "Adobe CC",       amount: 3480,  billing_cycle: :monthly, status: :cancelled, start_date: "2022-04-01" },
  # Yearly — active
  { title: "Amazon Prime",   amount: 5900,  billing_cycle: :yearly,  status: :active,    start_date: "2023-08-20" },
  { title: "NordVPN",        amount: 4900,  billing_cycle: :yearly,  status: :active,    start_date: "2024-05-10" },
  # Yearly — cancelled
  { title: "MS 365",         amount: 14900, billing_cycle: :yearly,  status: :cancelled, start_date: "2021-09-01" },
  # Weekly — active
  { title: "Duolingo+",      amount: 480,   billing_cycle: :weekly,  status: :active,    start_date: "2025-01-06" },
  # Weekly — paused
  { title: "News Digest",    amount: 300,   billing_cycle: :weekly,  status: :paused,    start_date: "2024-10-01" }
]

subscriptions.each do |attrs|
  admin.subscriptions.create!(attrs)
end

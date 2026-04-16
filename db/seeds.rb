User.destroy_all
Expense.destroy_all
Subscription.destroy_all

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

# Expenses
10.times do
  Expense.create!(
    title: [ "Groceries", "Rent", "Dinner", "Taxi", "Shopping" ].sample,
    amount: rand(500..10000),
    category: Expense.categories.keys.sample,
    date: Date.today - rand(1..30),
    user: user
  )
end

5.times do
  Expense.create!(
    title: [ "Business Expense", "Office Supplies", "Client Dinner" ].sample,
    amount: rand(1000..20000),
    category: Expense.categories.keys.sample,
    date: Date.today - rand(1..30),
    user: admin
  )
end

# Subscriptions
Subscription.create!(
  title: "Netflix",
  amount: 1200,
  billing_cycle: :monthly,
  start_date: Date.today - 100,
  status: :active,
  user: user
)

Subscription.create!(
  title: "Spotify",
  amount: 980,
  billing_cycle: :monthly,
  start_date: Date.today - 200,
  status: :active,
  user: user
)

Subscription.create!(
  title: "Gym",
  amount: 8000,
  billing_cycle: :monthly,
  start_date: Date.today - 300,
  status: :paused,
  user: user
)

Subscription.create!(
  title: "AWS",
  amount: 5000,
  billing_cycle: :monthly,
  start_date: Date.today - 150,
  status: :active,
  user: admin
)

Subscription.create!(
  title: "Domain Hosting",
  amount: 12000,
  billing_cycle: :yearly,
  start_date: Date.today - 365,
  status: :active,
  user: admin
)

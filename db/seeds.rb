
Subscription.destroy_all
Expense.destroy_all
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

admin = CreateAdminService.new.call
user = CreateUserService.new.call

puts 'Created Admin Username' << admin.username
puts 'CREATED ADMIN USER: ' << admin.email

puts 'Created  Username' << user.username
puts 'CREATED  Email: ' << user.email

Customer.create!([
  {
    customer_name: "Guest Test",
    phone: "123456789"
  }
])

ExchangeRate.create!([
    {
      usd_amount: 1,
      riel_amount: 4100
    }
])

Category.create!([
    {
      category_name: "Uncategory",
      admin_id: 1
    }
])

SeatTable.create!([
  {
    table_number: "Take Away"
  },
  {
    table_number: "Table 1"
  },
  {
    table_number: "Table 2"
  },
  {
    table_number: "Table 3"
  },
  {
    table_number: "Table 4"
  }
])

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191128123240) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.date "birthdate"
    t.integer "role"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.integer "pin"
    t.boolean "is_pin_required"
    t.string "username"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "admins_permissions", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "admin_id", null: false
    t.bigint "permission_id", null: false
    t.index ["admin_id", "permission_id"], name: "index_admins_permissions_on_admin_id_and_permission_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "category_name"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.index ["admin_id"], name: "index_categories_on_admin_id"
  end

  create_table "categories_products", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.index ["product_id", "category_id"], name: "index_categories_products_on_product_id_and_category_id"
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "customer_name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "photo"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "exchange_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "usd_amount"
    t.float "riel_amount", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "product_id"
    t.bigint "order_id"
    t.decimal "unit_price", precision: 12, scale: 3
    t.integer "quantity"
    t.decimal "total_price", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 12, scale: 3, default: "0.0"
    t.decimal "subtotal", precision: 12, scale: 3
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal "subtotal", precision: 12, scale: 3
    t.decimal "total", precision: 12, scale: 3
    t.date "order_date"
    t.bigint "user_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_name"
    t.boolean "is_paid", default: false
    t.time "order_time"
    t.decimal "tax", precision: 12, scale: 3, default: "0.0"
    t.decimal "shipping", precision: 12, scale: 3, default: "0.0"
    t.decimal "discount", precision: 12, scale: 3, default: "0.0"
    t.string "order_status"
    t.bigint "seat_table_id"
    t.integer "waitting_no"
    t.decimal "cash", precision: 12, scale: 3, default: "0.0"
    t.decimal "cash_in_riel", precision: 12, scale: 3, default: "0.0"
    t.decimal "total_cash_in_riel", precision: 12, scale: 3, default: "0.0"
    t.date "checkout_date"
    t.time "checkout_time"
    t.string "table_number"
    t.string "real_table_number"
    t.decimal "delivery_fee", precision: 12, scale: 3
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["seat_table_id"], name: "index_orders_on_seat_table_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "permissions_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "permission_id", null: false
    t.index ["user_id", "permission_id"], name: "index_permissions_users_on_user_id_and_permission_id"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "product_no"
    t.string "product_name"
    t.string "barcode"
    t.text "description"
    t.decimal "product_price", precision: 12, scale: 3
    t.decimal "sale_tax", precision: 12, scale: 3
    t.string "photo"
    t.boolean "active"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.text "image_data"
    t.index ["admin_id"], name: "index_products_on_admin_id"
  end

  create_table "seat_tables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "table_number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_seat_tables_on_admin_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.date "birthdate"
    t.string "role"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.integer "pin"
    t.boolean "is_pin_required"
    t.boolean "is_active", default: true
    t.string "username"
    t.integer "admin_id"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "categories", "admins"
  add_foreign_key "customers", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "seat_tables"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "admins"
  add_foreign_key "seat_tables", "admins"
end

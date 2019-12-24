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

ActiveRecord::Schema.define(version: 2019_12_21_061016) do

  create_table "luggage_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "luggage_id", comment: "托运ID"
    t.string "name", comment: "货物"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["luggage_id"], name: "index_luggage_items_on_luggage_id"
  end

  create_table "luggages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "no", null: false, comment: "托运单号 201912210001"
    t.integer "consignor_id", comment: "托运人"
    t.integer "items_count", default: 0, comment: "存件数"
    t.string "workflow_status", comment: "状态"
    t.integer "pay_status", default: 1, comment: "结账状态"
    t.string "user_name", null: false, comment: "用户名"
    t.string "mobile", comment: "手机号"
    t.integer "card_type", default: 1, comment: "证件类别"
    t.string "card_no", null: false, comment: "证件号"
    t.datetime "store_at", comment: "寄存时间"
    t.datetime "pick_at", comment: "取件时间"
    t.decimal "total_charge", precision: 20, scale: 2, default: "0.0", comment: "收费"
    t.text "remark", comment: "备注"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["no"], name: "index_luggages_on_no", unique: true
    t.index ["pay_status"], name: "index_luggages_on_pay_status"
    t.index ["user_name"], name: "index_luggages_on_user_name"
    t.index ["workflow_status"], name: "index_luggages_on_workflow_status"
  end

  create_table "simple_captcha_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", limit: 40
    t.string "value", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "idx_key"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "login_name", default: "", null: false, comment: "登录名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login_name"], name: "index_users_on_login_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

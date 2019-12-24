class CreateLuggages < ActiveRecord::Migration[5.2]
  def change
    create_table :luggages do |t|
      t.string :no, null: false, comment: "托运单号 201912210001"
      t.integer :consignor_id, comment: "托运人"
      t.integer :items_count, default: 0, comment: "存件数"
      t.string :workflow_status, comment: "状态"
      t.integer :pay_status, default: 1, comment: "结账状态"
      t.string :user_name, null: false, comment: "用户名"
      t.string :mobile, comment: "手机号"
      t.integer :card_type, default: 1, comment: "证件类别"
      t.string :card_no, null: false, comment: "证件号"
      t.datetime :store_at, comment: "寄存时间"
      t.datetime :pick_at, comment: "取件时间"
      t.decimal :total_charge, precision: 20, scale: 2, default: 0, comment: "收费"
      t.text :remark, comment: "备注"
      t.timestamps
    end

    create_table :luggage_items do |t|
      t.references :luggage, comment: "托运ID"
      t.string :name, comment: "货物"
      t.timestamps
    end

    add_index :luggages, :no, unique: true
    add_index :luggages, :user_name
    add_index :luggages, :workflow_status
    add_index :luggages, :pay_status

  end
end

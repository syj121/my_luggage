class AddIndexDayToLuggage < ActiveRecord::Migration[5.2]
  def change
    add_column :luggages, :index_day, :integer, comment: "日期 天"
    add_index :luggages, :index_day
  end
end

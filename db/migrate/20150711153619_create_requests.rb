class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :type
      t.datetime :created
      t.datetime :expires
      t.decimal :longtitude
      t.decimal :latitude

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :number
      t.integer :credits
      t.decimal :cash
      t.decimal :reputation
      t.integer :requested
      t.integer :received
      t.integer :voteUp
      t.integer :voteDown

      t.timestamps null: false
    end
  end
end

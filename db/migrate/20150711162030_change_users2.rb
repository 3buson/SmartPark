class ChangeUsers2 < ActiveRecord::Migration
  def change
  	change_column :users, :reputation, :decimal, :default => 0
  end
end

class ChangeUsers < ActiveRecord::Migration
  def change
  	change_column :users, :credits, :integer, :default => 0
  	change_column :users, :cash, :decimal, :default => 0
  	change_column :users, :requested, :integer, :default => 0
  	change_column :users, :received, :integer, :default => 0
  	change_column :users, :voteUp, :integer, :default => 0
  	change_column :users, :voteDown, :integer, :default => 0
  end
end

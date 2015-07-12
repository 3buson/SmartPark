class ChangeRequests < ActiveRecord::Migration
  def change
  	rename_column :requests, :type, :requestType
  end
end

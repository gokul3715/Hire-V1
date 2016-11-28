class RemoveCompanyNameFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :company
  end
end

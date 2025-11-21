class RemoveEmailAddressFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :email_address
  end
end

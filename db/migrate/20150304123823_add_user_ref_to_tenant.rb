class AddUserRefToTenant < ActiveRecord::Migration
  def change
    add_reference :tenants, :user, index: true
  end
end

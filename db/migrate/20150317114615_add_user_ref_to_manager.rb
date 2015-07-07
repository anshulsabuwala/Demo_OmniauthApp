class AddUserRefToManager < ActiveRecord::Migration
  def change
    add_reference :managers, :user, index: true
  end
end

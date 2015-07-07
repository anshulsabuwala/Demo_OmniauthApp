class AddUserRefToLandlord < ActiveRecord::Migration
  def change
    add_reference :landlords, :user, index: true
  end
end

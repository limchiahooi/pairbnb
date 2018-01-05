class AddVerificationToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :verification, :integer, default: 0
  end
end

class ChangeEmailTypeInHospitals < ActiveRecord::Migration[7.0]
  def change
    add_column :hospitals, :pincode, :integer
    change_column :hospitals, :email, :string

  end
end

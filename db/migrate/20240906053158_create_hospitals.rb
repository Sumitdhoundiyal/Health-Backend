class CreateHospitals < ActiveRecord::Migration[7.0]
  def change
    create_table :hospitals do |t|
      t.string :hospital_name
      t.string :hospital_address_line1
      t.string :hospital_address_line2
      t.string :hospital_address_line3
      t.integer :contact_number
      t.integer :email
      t.string :hospital_type
      t.timestamps
    end
  end
end

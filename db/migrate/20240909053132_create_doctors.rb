class CreateDoctors < ActiveRecord::Migration[7.0]
  def change

    create_table :doctors do |t|
      t.string :first_name,null: false
      t.string :last_name,null: false
      t.string :specialization, null: false
      t.string :email
      t.string :contact_number




      t.timestamps
    end
  end
end

class Removehospitailidtodoctors < ActiveRecord::Migration[7.0]
  def change
    remove_column :doctors, :hospital_id

  end
end

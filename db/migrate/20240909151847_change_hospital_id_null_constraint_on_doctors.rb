class ChangeHospitalIdNullConstraintOnDoctors < ActiveRecord::Migration[7.0]
  def change
    change_column_null :doctors, :hospital_id, true
  end
end

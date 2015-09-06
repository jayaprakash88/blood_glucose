class CreateGlucoseReadings < ActiveRecord::Migration
  def change
    create_table :glucose_readings do |t|
      t.integer :patient_id
      t.integer :reading

      t.timestamps null: false
    end
  end
end

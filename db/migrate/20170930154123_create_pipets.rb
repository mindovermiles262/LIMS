class CreatePipets < ActiveRecord::Migration[5.1]
  def change
    create_table :pipets do |t|
      t.datetime :calibration_date
      t.datetime :calibration_due
      t.integer :min_volume
      t.integer :max_volume
      t.boolean :adjustable

      t.timestamps
    end
  end
end

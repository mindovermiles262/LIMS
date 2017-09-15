class CreateTestMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :test_methods do |t|
      t.string :name
      t.string :target_organism
      t.string :reference_method
      t.integer :turn_around_time
      t.integer :detection_limit
      t.integer :batch_id
      t.string :unit

      t.timestamps
    end
  end
end

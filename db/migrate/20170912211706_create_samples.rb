class CreateSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :samples do |t|
      
      t.string :description
      t.string :lot
      t.integer :result, default: nil
      t.boolean :batched, default: false

      t.references :project
      t.references :test_method

      t.timestamps
    end
  end
end
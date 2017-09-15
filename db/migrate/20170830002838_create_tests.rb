class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.integer :result, default: nil
      t.boolean :PA, default: false
      t.references :test_method
      t.references :sample
      t.references :user
      t.references :analysts
      t.references :batch
      t.string :description
      t.boolean :batched, default: false

      t.timestamps
    end
  end
end

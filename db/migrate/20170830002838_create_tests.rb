class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.integer :result, default: nil
      t.boolean :received, default: false
      t.boolean :started, default: false
      t.boolean :completed, default: false
      t.boolean :reported, default: false
      t.boolean :invoiced, default: false
      t.boolean :paid, default: false
      t.boolean :PA, default: false
      t.references :test_method
      t.references :project
      t.references :user
      t.references :analysts

      t.timestamps
    end
  end
end

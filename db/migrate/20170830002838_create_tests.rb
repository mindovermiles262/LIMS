class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.integer :result, default: nil
      t.boolean :PA, default: false
      t.references :test_method
      t.references :project
      t.references :user
      t.references :analysts
      t.string :description

      t.timestamps
    end
  end
end

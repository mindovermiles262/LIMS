class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.integer :test_method_id
      t.integer :test_id
      t.timestamps
    end
  end
end

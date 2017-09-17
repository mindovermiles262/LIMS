class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.references :test_method
      t.references :test
      t.timestamps
    end
  end
end

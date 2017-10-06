class CreateBatchPipets < ActiveRecord::Migration[5.1]
  def change
    create_table :batch_pipets do |t|
      t.integer :batch_id
      t.integer :pipet_id

      t.timestamps
    end
  end
end

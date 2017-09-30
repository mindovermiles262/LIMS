class CreateBatchesPipetsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :batches_pipets, id: false do |t|
      t.integer :batch_id
      t.integer :pipet_id
    end
  end
end

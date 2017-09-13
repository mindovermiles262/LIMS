class CreateSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :samples do |t|
      t.string :description
      t.references :project
      t.references :tests

      t.timestamps
    end
  end
end

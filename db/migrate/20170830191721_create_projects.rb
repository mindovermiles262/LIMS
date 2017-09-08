class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :user
      t.references :tests
      t.boolean :complete, default: false
      t.string :description, default: ""
      t.string :lot, default: ""

      t.timestamps
    end
  end
end

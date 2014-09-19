class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string :name
      t.integer :category_id
      t.integer :initiator_id
      t.string :initial_text

      t.timestamps
    end
  end
end

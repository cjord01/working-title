class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|

      t.string :contribution
      t.integer :contributor_id
      t.integer :project_id
      t.integer :previous_version_id
      t.integer :insertion_index


      t.timestamps
    end
  end
end

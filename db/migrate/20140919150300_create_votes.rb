class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.boolean :positive
      # t.references :voteable, polymorphic: true
      t.integer :voteable_id
      t.string :voteable_type

      t.timestamps
    end
  end
end

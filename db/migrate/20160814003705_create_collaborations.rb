class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
       t.references :user, index: true
       t.references :collaborable, polymorphic: true, index: true
       t.timestamps null: false
     end
     add_foreign_key :collaborations, :users
    end
end

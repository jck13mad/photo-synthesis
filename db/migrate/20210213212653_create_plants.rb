class CreatePlants < ActiveRecord::Migration[6.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :img
      t.string :description
      t.belongs_to :user, null: false, foreign_key: true 
      t.belongs_to :type, null: false, foreign_key: true 

      t.timestamps
    end
  end
end

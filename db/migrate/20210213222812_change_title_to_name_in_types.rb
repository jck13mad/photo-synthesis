class ChangeTitleToNameInTypes < ActiveRecord::Migration[6.1]
  def change
    rename_column :types, :title, :name 
  end
end

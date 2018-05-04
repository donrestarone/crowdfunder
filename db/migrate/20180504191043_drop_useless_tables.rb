class DropUselessTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :category_tables
    drop_table :category
    add_column :categories, :name, :string
  end
end

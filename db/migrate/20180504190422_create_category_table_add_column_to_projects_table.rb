class CreateCategoryTableAddColumnToProjectsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :category do |t|
      t.string :name
    end

    add_column :projects, :category_id, :integer
  end
end

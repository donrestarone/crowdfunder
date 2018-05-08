class CreateCategoryTableAddColumnToProjectsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
    end

    add_column :projects, :category_id, :integer
  end
end

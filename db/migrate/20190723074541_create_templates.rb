class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :title, null: false, limit: 100
      t.string :description, limit: 400
      t.text :full_content
      t.text :body
      t.timestamps
    end
  end
end

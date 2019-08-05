class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.integer :translation_text_id
      t.text :html_body
      t.json :translation_json
      t.integer :version_number
      t.timestamps
    end
  end
end

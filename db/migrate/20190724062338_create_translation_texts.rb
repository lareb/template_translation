class CreateTranslationTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :translation_texts do |t|
      t.integer :template_id, null: false
      t.integer :local
      t.json :key_value
      t.text :template_body
      t.boolean :is_core, default: false
      t.timestamps
    end
  end
end

class AddFreezField < ActiveRecord::Migration[5.2]
  def change
    add_column :translation_texts, :freez, :boolean, default: false
    add_column :versions, :freez, :boolean, default: false
    add_column :translation_texts, :error_message, :string
  end
end

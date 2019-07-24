class Template < ApplicationRecord
  has_many :translation_texts

  # after_save :create_translation_entry

  private
  def create_translation_entry

  end

end

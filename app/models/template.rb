class Template < ApplicationRecord
  has_many :translation_texts

  after_update :clear_translations

  private
  def clear_translations
    # update(key_value: nil)
  end

end

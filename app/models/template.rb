class Template < ApplicationRecord
  has_many :translation_texts, dependent: :destroy

  # after_update :update_translations
  # validate :validate_template
  # after_create_commit :fetch_text
  # private
  # update translations
  def update_translations
    puts "------------XXXXXXXXXXXXXXXXXXXX--------------------"
    ap "After updating template>>>>>"
    locales = translation_texts.select(:local).map(&:local)
    ap locales
    locales.each do |locale|
      translation = translation_texts.find_by(local: locale)
      translation.translate_texts
      # translation.update(text_keys: template.key_value, template_with_key: template.template_with_key)
    end
  end
end

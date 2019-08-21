class Template < ApplicationRecord
  attr_accessor :locales
  default_scope { order(updated_at: :desc) }
  has_many :translation_texts, dependent: :destroy

  # after_save :create_translation_text

  def locales
    translation_texts.select(:local).map(&:local)
  end

  def update_translations
    puts "------------XXXXXXXXXXXXXXXXXXXX--------------------"
    puts "After updating template>>>>>"

    locales = translation_texts.select(:local).map(&:local)
    puts locales
    locales.each do |locale|
      translation = translation_texts.find_by(local: locale)
      translation.translate_texts
      # translation.update(text_keys: template.key_value, template_with_key: template.template_with_key)
    end
  end

  # private
  def create_translation_text(locales)
    puts "-----8*************8--------"

    if locales.empty?
      update_translations
    else
      locales.each do |locale|
        trx = translation_texts.create!({local: locale})
      end
    end

  end

end

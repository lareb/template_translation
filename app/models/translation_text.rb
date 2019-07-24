class TranslationText < ApplicationRecord
  enum local: SUPPORTED_LOCALE.map(&:first)
  belongs_to :template

  after_save :translate_texts

  private
  def translate_texts
    puts "===========================================================--000000000"
    puts "Translate text"
  end

end

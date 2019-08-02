include Translation
class TranslationText < ApplicationRecord
  attr_accessor :text_keys, :template_with_key

  enum local: SUPPORTED_LOCALE.map(&:first)
  belongs_to :template

  validates :local, presence: true
  validates :local, uniqueness: { scope: [:template_id] }
  

  after_create_commit :translate_texts

  private
  def translate_texts
    json = JSON.parse(text_keys)
    template.update(key_value: json, template_with_key: template_with_key)
    TranslationJob.perform_later(self)
  end

end

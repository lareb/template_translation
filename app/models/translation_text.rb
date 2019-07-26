include Translation
class TranslationText < ApplicationRecord
  attr_accessor :text_keys

  enum local: SUPPORTED_LOCALE.map(&:first)
  belongs_to :template

  validates :local, presence: true
  # validates_uniqueness_of :local, scope: [:template_id]

  after_save :translate_texts

  private
  def translate_texts
    json = JSON.parse(text_keys)
    template.update(key_value: json)
    begin
      trabslated_blob = {}
      template.key_value.each do |k, v|
          trabslated_blob[k] = translate(v, local)
      end

      update({key_value: trabslated_blob})
    rescue Exception => e
      puts "===================="
      logger.error e.message
    end
  end

end

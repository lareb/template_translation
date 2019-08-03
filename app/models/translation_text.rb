include Translation
class TranslationText < ApplicationRecord
  after_create_commit :translate_texts
  audited only: [:key_value, :template_body], on: [:update, :destroy]
  # paper_trail.on_update
  # has_paper_trail only: [:key_value, :template_body], on: [:update] #, if: Proc.new { |t| ap "#{t.key_value} ===>"; !t.key_value.nil? }
  # paper_trail.on_create
  # paper_trail.on_update     # etc.


  attr_accessor :text_keys, :template_with_key

  enum local: SUPPORTED_LOCALE.map(&:first)
  belongs_to :template

  validates :local, presence: true
  validates :local, uniqueness: { scope: [:template_id] }



  # paper_trail.on_create #:translate_texts
  # user.without_versioning { |obj| obj.update_attributes(attribute: 'new_value') }
  # private
  def translate_texts
    puts "============================back ground job should start--------"
    # ap text_keys
    # json = JSON.parse(text_keys)
    ap text_keys
    # template.update(key_value: json, template_with_key: template_with_key)
    TranslationJob.perform_later(self)
  end

end

include Translation
class TranslationText < ApplicationRecord
  attr_accessor :text_keys, :template_with_key, :create_new_version, :update_version

  after_create_commit :translate_texts
  after_update :create_version
  # audited only: [:key_value, :template_body], on: [:update, :destroy], if: :active?


  enum local: SUPPORTED_LOCALE.map(&:first)
  belongs_to :template
  has_many :versions

  validates :local, presence: true
  validates :local, uniqueness: { scope: [:template_id] }

  def translate_texts
    job = TranslationJob.perform_later(self)
    # puts "-%%%%%%%%%%%%%%%%%%%%%%%%%%%-"
    # ap job.job_id
    # ap Sidekiq::Queue.new.find_job(job.job_id)
    # update(job_id: job.job_id)
  end

  private
  def create_version
    if create_new_version == true
      puts "+++++++++++++++++++++Version created"
      Version.create!({translation_text_id: self.id, html_body: template_body, translation_json: key_value})
    end

    if update_version == true
      puts "----------------------Same Version updated"
      versions.last.update({translation_text_id: self.id, html_body: template_body, translation_json: key_value})
    end
  end

end

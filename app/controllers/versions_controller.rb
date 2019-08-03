class VersionsController < ApplicationController
  before_action :set_template
  before_action :set_translation_text

  def index
    @versions = @translation_text.audits
  end

  def show
    @version = @translation_text.audits.find(params[:id])
    @version_template = @version.audited_changes['template_body'].try(:last)
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:template_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_translation_text
      puts "=======sfsffgfd==========="
      ap params[:translation_text_id]
      @translation_text = TranslationText.find(params[:translation_text_id])
    end
end

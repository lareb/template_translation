class VersionsController < ApplicationController
  before_action :set_template
  before_action :set_translation_text
  before_action :set_version, only: [:show, :edit, :update, :destroy]

  # GET /versions
  # GET /versions.json
  def index
    @versions = @translation_text.versions
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
    # puts "-----------sadfreyeyturr-yt-----"
    # ap @version
    render layout: false
  end

  def diff
    @v1 = @translation_text.versions.find_by(id: params[:v1])
    @v2 = @translation_text.versions.find_by(id: params[:v2])
    invalid_version = @v1.try(:id) || @v2.try(:id)
    if @v1.nil? || @v2.nil?
      redirect_to template_translation_text_versions_path(@template, @translation_text), notice: "Invalid Version with Id = #{invalid_version}"
    end
  end

  # # GET /versions/new
  # def new
  #   @version = Version.new
  # end
  #
  # GET /versions/1/edit
  def edit
  end

  # POST /versions
  # POST /versions.json
  def create
    @version = @translation_text.versions.new(new_params)

    respond_to do |format|
      if @version.save!
        format.js {
          render status: 200
        }
      else
        format.js {
          render status: 404
        }
      end
    end
  end
  #
  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    respond_to do |format|
      if @version.update(new_params)
        format.js {
          render status: 200
        }
      else
        format.js {
          render status: 404
        }
      end
    end
  end

  # DELETE /versions/1
  # DELETE /versions/1.json
  def destroy
    @version.destroy
    respond_to do |format|
      format.html { redirect_to versions_url, notice: 'Version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:template_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_translation_text
      @translation_text = TranslationText.find(params[:translation_text_id])
    end

    # def surprace_scripts
    #   start_field = '<!--PREVIEW-FIELDS-->'
    #   end_field = '<!--/PREVIEW-FIELDS-->'
    #
    #   ap version_params[:html_body]
    #   text = version_params[:html_body][/#{start_field}(.*?)#{end_field}/m, 1]
    #   chopped_str = version_params[:html_body].chomp(text)
    #
    #   start_form = '<!--PREVIEW-FORMS-->'
    #   end_form = '<!--/PREVIEW-FORMS-->'
    #   final_text = chopped_str[/#{start_form}(.*?)#{end_form}/m, 1]
    #   final_chopped_text = chopped_str.chomp(final_text)
    #   puts "=======================X==============EWRTETE============="
    #   ap final_chopped_text
    #   return final_chopped_text
    # end

    def surprace_scripts
      start_field = '<!--PREVIEW-FIELDS-->'
      end_field = '<!--/PREVIEW-FIELDS-->'
      # for forms
      start_form = '<!--PREVIEW-FORMS-->'
      end_form = '<!--/PREVIEW-FORMS-->'

      html_body = version_params[:html_body]

      text = html_body[/#{start_field}(.*?)#{end_field}/m, 1]
      chopped_str = html_body.gsub(text, '')

      text = chopped_str[/#{start_form}(.*?)#{end_form}/m, 1]
      final_chopped_str = chopped_str.gsub(text, '')

      final_chopped_str.gsub!(start_field, '')
      final_chopped_str.gsub!(end_field, '')
      final_chopped_str.gsub!(start_form, '')
      final_chopped_str.gsub!(end_form, '')

      return final_chopped_str
    end

    def new_params
      scaped_params = version_params
      start_field = '<!--PREVIEW-FIELDS-->'
      end_field = '<!--/PREVIEW-FIELDS-->'
      # for forms
      start_form = '<!--PREVIEW-FORMS-->'
      end_form = '<!--/PREVIEW-FORMS-->'

      scaped_params[:html_body] = surprace_scripts
      puts "00000000000000000000000000000000000"
      ap scaped_params
      ap scaped_params[:html_body].index(start_field)
      ap scaped_params[:html_body].index(end_field)
      ap scaped_params[:html_body].index(start_form)
      ap scaped_params[:html_body].index(end_form)
      puts "-------------xxx-----------------"
      return scaped_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
      params.require(:version).permit(:translation_text_id, :html_body, :translation_json)
    end
end

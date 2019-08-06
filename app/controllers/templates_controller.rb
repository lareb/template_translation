class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy, :preview, :in_process, :update_core_template]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    # render layout: false
  end

  def preview
    render layout: false
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  def in_process
    @locales = params[:locales].to_s.split(",") || []
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(updated_params)
    locales = (params[:template][:locales] || []).join(',')
    respond_to do |format|
      if @template.save
        format.html { redirect_to in_process_template_path(@template, {locales: locales}), notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    locales = (params[:template][:locales] || []).join(',')
    puts "=========saddfsf========"
    respond_to do |format|
      if @template.update(updated_params)
        # @template.update_translations
        format.html { redirect_to in_process_template_path(@template, {locales: locales} ), notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_core_template
    locales = params[:template][:locales] || []
    respond_to do |format|
      # @translation_text.without_auditing do
      if @template.update(updated_params)
        # @template.update_translations
        @template.create_translation_text(locales)
        format.html { redirect_to template_translation_texts_path(@template), notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # read file line
    def updated_params
      file_data = params[:file]
      new_params = template_params

      new_params['locales'] = params[:template][:locales]
      puts "---------without file params-------"
      return new_params if file_data.blank?
      puts "=============FILE PARAMS==============="
      if file_data.respond_to?(:read)
        @lines = file_data.read
      elsif file_data.respond_to?(:path)
        @lines = File.read(file_data.path)
      else
        logger.error "Bad file_data: #{file_data.class.name}: # {@filename.inspect}"
      end
      # @lines = params[:template][:full_content]
      # new_params = template_params
      new_params['full_content'] = @lines
      new_params['body'] = crop_body(@lines)
      # new_params['locales'] = params[:template][:locales]
      return new_params
    end

    def crop_body(full_content)
      doc = Nokogiri::HTML(full_content)
      body = doc.at('body').inner_html
      return body
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:body, :title, :description, :template, :template_with_key, :key_value, locales: [])
    end
end

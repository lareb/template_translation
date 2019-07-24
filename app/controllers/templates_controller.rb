class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy, :preview]

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

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(updated_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to @template, notice: 'Template was successfully created.' }
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
    # puts "=============345et==========="
    # ap updated_params
    respond_to do |format|
      if @template.update(updated_params)
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
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

      if file_data.respond_to?(:read)
        @lines = file_data.read
      elsif file_data.respond_to?(:path)
        @lines = File.read(file_data.path)
      else
        logger.error "Bad file_data: #{file_data.class.name}: # {@filename.inspect}"
      end

      new_params = template_params
      new_params['full_content'] = @lines
      new_params['body'] = crop_body(@lines)
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
      params.require(:template).permit(:body, :title, :description, :template)
    end
end

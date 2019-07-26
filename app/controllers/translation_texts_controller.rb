class TranslationTextsController < ApplicationController
  before_action :set_template
  before_action :set_translation_text, only: [:show, :edit, :update, :destroy]

  # GET /translation_texts
  # GET /translation_texts.json
  def index
    @translation_texts = TranslationText.all
  end

  # GET /translation_texts/1
  # GET /translation_texts/1.json
  def show
  end

  # GET /translation_texts/new
  def new
    @translation_text = @template.translation_texts.new
  end

  # GET /translation_texts/1/edit
  def edit
    # @translation_text = @template.translation_texts
  end

  # POST /translation_texts
  # POST /translation_texts.json
  def create
    # ap translation_text_params
    # update_params = translation_text_params
    # update_params[:template_id] = @template.id
    @translation_text = @template.translation_texts.new(translation_text_params)

    respond_to do |format|
      if @translation_text.save
        # should change the path
        format.html { redirect_to templates_path, notice: 'Translation text was successfully created.' }
        format.json { render :show, status: :created, location: @translation_text }
      else
        format.html { render :new }
        format.json { render json: @translation_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /translation_texts/1
  # PATCH/PUT /translation_texts/1.json
  def update
    respond_to do |format|
      if @translation_text.update(translation_text_params)
        format.html { redirect_to templates_path, notice: 'Translation text was successfully updated.' }
        format.json { render :show, status: :ok, location: @translation_text }
      else
        format.html { render :edit }
        format.json { render json: @translation_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /translation_texts/1
  # DELETE /translation_texts/1.json
  def destroy
    @translation_text.destroy
    respond_to do |format|
      format.html { redirect_to translation_texts_url, notice: 'Translation text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:template_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_translation_text
      @translation_text = TranslationText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def translation_text_params
      params.require(:translation_text).permit(:template_id, :local, :key_value, :text_keys)
    end
end

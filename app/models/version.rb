class Version < ApplicationRecord
  belongs_to :translation_text

  after_create_commit :update_version_number

  def surprace_scripts
    start_field = '<!--PREVIEW-FIELDS-->'
    end_field = '<!--/PREVIEW-FIELDS-->'
    # for forms
    start_form = '<!--PREVIEW-FORMS-->'
    end_form = '<!--/PREVIEW-FORMS-->'

    text = html_body[/#{start_field}(.*?)#{end_field}/m, 1]
    chopped_str = html_body.gsub(text, '')

    text = chopped_str[/#{start_form}(.*?)#{end_form}/m, 1]
    final_chopped_str = chopped_str.gsub(text, '')

    final_chopped_str.gsub!(start_field, '')
    final_chopped_str.gsub!(end_field, '')
    final_chopped_str.gsub!(start_form, '')
    final_chopped_str.gsub!(end_form, '')
    puts "00000000000000000000000000000000000"
    ap final_chopped_str

    return final_chopped_str
  end

  private
  def update_version_number
    update({version_number: translation_text.versions.count - 1})
  end
end

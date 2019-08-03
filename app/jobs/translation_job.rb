class TranslationJob < ApplicationJob
  queue_as :default

  def perform(translation_text)
    template = translation_text.template
    begin
      translated_blob = {}
      # get key and translation hash
      translated_template = template.template_with_key
      JSON.parse(template.key_value).each do |k, v|
        # Translate text and create new hash
        translated_string = translate(v, translation_text.local)
        translated_blob[k] = translated_string
        # replace translated text into Template
        translated_template.gsub!(k, translated_string)
      end
      # set translated template
      full_html = replace_placeholder(template, translated_template)
      puts "=======================fdgdd=============="
      ap full_html
      #  this should be save without auditing
      # translation_text.without_auditing do
      # translation_text.key_value = translated_blob
      # translation_text.template_body = full_html
      # translation_text.save_without_auditing
      translation_text.update({key_value: translated_blob, template_body: full_html})
      # end
    rescue Exception => e
      puts "===================="
      ap e
      ap e.message
    end
  end

  #
  def replace_placeholder(template, translated_template)
    doc = Nokogiri::HTML(template.full_content)
    doc.at('body').content = template.template_with_key.html_safe #translated_template
    return CGI.unescapeHTML(doc.to_html)
  end

end

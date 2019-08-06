class TranslationJob < ApplicationJob
  queue_as :default

  def perform(translation_text, create_new_version = true)
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
      puts "=======================fdgdd============= Count = #{translation_text.versions.count}"
      translation_text.update({key_value: translated_blob, template_body: full_html, create_new_version: create_new_version})
    rescue Exception => e
      # Record error here for each and every translation
      # Reflect error if any
      puts "===================="
      puts e
      puts e.message
      # translation_text.update({error_message: e.message})
    end
  end

  #
  def replace_placeholder(template, translated_template)
    doc = Nokogiri::HTML(template.full_content)
    doc.at('body').content = template.template_with_key.html_safe #translated_template
    return CGI.unescapeHTML(doc.to_html)
  end

end

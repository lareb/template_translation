require "google/cloud/translate"

module Translation
  def translate(text, locale)
    return text if locale == 'en'
    puts "#{locale}-----------------xxx-----------------, should nt come here if lcal is en"
    translate = Google::Cloud::Translate.new(
      key: "#{ENV['GOOGLE_TRANSLATION_KEY']}"
    )

    translation = translate.translate(text, to: locale)
    translation.text || text
  end
end

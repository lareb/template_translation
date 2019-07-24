require "google/cloud/translate"

module Translation
  def translate(text, locale)
    translate = Google::Cloud::Translate.new(
      key: "#{ENV['GOOGLE_TRANSLATION_KEY']}"
    )

    translation = translate.translate(text, to: locale)
    translation.text
  end
end

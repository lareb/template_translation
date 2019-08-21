class PdfGenerationJob < ApplicationJob
  queue_as :default
  # sidekiq_options backtrace: true
  # options backtrace: true

  def perform(version, imagePath, outputPath, width, height)
    # Do something later
    puts "PDF Generation started-------------------123"
    puts "bhai sahab"
    # puts "#{image}"
    puts "#{outputPath}"
    puts "=========xxxxx=================="

    translation_text = version.translation_text
    template = translation_text.template

    # file_name = pdf_file_name(template, translation_text, version)

    body = {
      format: 'pdf',
      # public path
      filePath: "#{imagePath}",
      outputPath: "#{outputPath}",
      quality: 100,
      dimension: {
        height: height,
        width: width
      }
    }
    phantom_url = "#{ENV['DOWNLOAD_SERVICE_URL']}:#{ENV['DOWNLOAD_SERVICE_PORT']}/generate"
    # begin
      response = HTTParty.post(
        phantom_url,
        body: body.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    #  end
  end

  # def pdf_file_name(template, translation_text, version)
  #   "#{template.title.parameterize}-#{translation_text.local}-#{version.version_number}.pdf"
  # end

  # def create_folder(template, translation_text, version)
  #   FileUtils.mkdir_p("/pdfs/#{template.id}/#{translation_text.local}/#{version.version_number}")
  # end


end

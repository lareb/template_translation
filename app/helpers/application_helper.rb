module ApplicationHelper
  def get_local_word(locale)
    if locale == 'en'
      'English'
    elsif locale == 'hi'
      'हिंदी'
    elsif locale == 'mr'
      'मराठी'
    elsif locale == 'ta'
      'தமிழ்'
    elsif locale == 'te'
      'తెలుగు'
    end
  end

  def preview_enabled(template_text)
    puts "-------------deew"
    ap preview_assets
    return template_text.gsub("</head>", "#{preview_assets}</head>")
  end

  def version_preview_enabled(yaml_object)
    puts "-------------deew"
    puts yaml_object
    template_text = PaperTrail.serializer.load(yaml_object)

    return template_text['template_body'].gsub("</head>", "#{preview_assets}</head>")
  end

  def preview_assets
    return %{
      <link href="/css/bootstrap-editable.css" rel="stylesheet">
      <link href="/css/preview.css" rel="stylesheet">
      <link href="/css/bootstrap.css" rel="stylesheet">
      <link href="/css/bootstrap-responsive.css" rel="stylesheet">

      <script src="/js/jquery-1.9.1.min.js"></script>
      <script src="/js/bootstrap.js"></script>
      <script src="/js/bootstrap-editable.js"></script>
      <script src="/js/preview.js"></script>
    }
  end
end

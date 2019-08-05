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

  def preview_enabled(template_text, version)

    return version.try(:html_body) unless template_text.versions.last.try(:id) == version.id


    text = version.try(:html_body)
    hidden_fields = hidden_fields(template_text, version)
    return text.gsub("</head>", "#{preview_assets}</head>").gsub('</body>', "#{hidden_fields}</body>")
  end

  def hidden_fields(template_text, version)

    return %{
      <!--PREVIEW-FORMS-->
      <div class="navbar"><a href="#home" class="active">Home</a><a href="#news">News</a><a href="#contact">Contact</a></div>
      <input type="hidden" value="#{template_text.id}" id="template_text_id" />
      <input type="hidden" value="#{template_translation_text_version_path(template_text.template, template_text, version)}" id="edit_form_url" />
      <input type="hidden" value="#{template_translation_text_versions_path(template_text.template, template_text)}" id="new_form_url" />
      <!--/PREVIEW-FORMS-->
    }
  end

  def preview_assets
    return %{
      <!--PREVIEW-FIELDS-->
      <link href="/css/bootstrap-editable.css" rel="stylesheet">
      <link href="/css/preview.css" rel="stylesheet">
      <link href="/css/bootstrap.css" rel="stylesheet">
      <link href="/css/bootstrap-responsive.css" rel="stylesheet">
      #{csrf_meta_tag}
      <script src="/js/jquery-1.9.1.min.js"csrf-token></script>
      <script src="/js/bootstrap.js"></script>
      <script src="/js/bootstrap-editable.js"></script>
      <script src="/js/preview.js"></script>
      <!--/PREVIEW-FIELDS-->
    }
  end
end

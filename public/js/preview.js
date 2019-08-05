// alert("Hello world");
// $.fn.editable.defaults.mode = 'inline';
$( document ).ready(function() {
  // $.fn.editable.defaults.mode = 'inline'

  $("span.translation").map(function(index, key){
    let originalText = $(key).text();
    console.log(index, originalText.length);
    let dataType = 'text';
    if(originalText.length > 50){
      dataType = 'textarea';
    }
    $(key).attr({'data-type': dataType, 'data-pk': index, 'data-original-title': originalText});
    $(key).editable();
  })

  // setTimeout(function(){
  //   let x = '<div class="navbar"><a href="#home" class="active">Home</a><a href="#news">News</a><a href="#contact">Contact</a></div>';
  //   $('body').append(x);
  // }, 500);
});

function updateVersion(){
  let edit_url = $("#edit_form_url").val();
  saveChanges('PUT', edit_url);
}

function saveAsNewVersion(){
  let new_url = $("#new_form_url").val();
  console.log(new_url, "========etetyryrut=======")
  saveChanges('POST', new_url);
}

function saveChanges(method, url){
  console.log(url, "===================ggffd");
  let translation_text_id = $("template_text_id").val();
  let body = getHTML();
  let data = {
      version: {
        translation_text_id: translation_text_id,
        html_body: body
      }
  }
  var saveData = $.ajax({
    type: method,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content') ) },
    url: url,
    data: data,
    dataType: "text",
    success: function(resultData) {
      alert("Save Complete")
      if(method == 'PUT'){
        window.location.reload();
      }else{
        let new_url = $("#new_form_url").val();
        window.location.href = new_url
      }

    }
  });
  saveData.error(function() { alert("Something went wrong"); });

}

function getHTML(){
  return getDocTypeAsString() + document.documentElement.outerHTML;
}


var getDocTypeAsString = function () {
    var node = document.doctype;
    return node ? "<!DOCTYPE "
         + node.name
         + (node.publicId ? ' PUBLIC "' + node.publicId + '"' : '')
         + (!node.publicId && node.systemId ? ' SYSTEM' : '')
         + (node.systemId ? ' "' + node.systemId + '"' : '')
         + '>\n' : '';
};

// alert("Hello world");
// $.fn.editable.defaults.mode = 'inline';
$( document ).ready(function() {
  // $.fn.editable.defaults.mode = 'inline'

  $("span.translation-required").map(function(index, key){
    let originalText = $(key).text();
    // console.log(index, originalText.length);
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

function freezVersion(){
  let freez_url = $("#freez_version_url").val();
  // saveChanges('PUT', edit_url);
  let r = confirm("Are you sure, you want to freez this version?");
  if (r == true) {
    ajaxCall('PUT', freez_url, {});
  }
  console.log("==========adff========")

}


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

  ajaxCall(method, url, data);
}

function ajaxCall(method, url, data){
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

// initiate pdf generation
// var myInterval;
function generatePDF(url, download_url){

  prepareImage().then(function(imageData){
    let docHeight = $("#parent").height();
    let docWidth = $("#parent").width();

    var saveData = $.ajax({
      type: 'POST',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content') ) },
      url: url,
      data: {image: imageData, docHeight: docHeight, docWidth: docWidth},
      dataType: "text",
      success: function(resultData) {
        console.log(resultData, "=============543564")
        setTimeout(function(){
          window.location.href = download_url
        }, 8000)
      }
    });
    saveData.error(function(x) {
      console.log(x, "============356464============")
      alert("Something went wrong");
    });

  })
}

function stopFunction(){
    clearInterval(myInterval); // stop the timer
}
// https://openlayers.org/en/latest/examples/export-pdf.html
// https://gist.github.com/shrikanthkr/10097999
function prepareImage(){
  $("div.navbar").hide();
  $("#parent").html('');
  let baseImage = html2canvas(document.body).then(function(canvas) {
      // Export the canvas to its data URI representation
      var base64image = canvas.toDataURL("image/png");
      var pHtml = "<img src="+base64image+" />";
      $("#parent").append(pHtml);
      return base64image;
  });

  $("div.navbar").show();
  return baseImage;
}

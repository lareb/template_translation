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



})

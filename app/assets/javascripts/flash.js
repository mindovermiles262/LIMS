$(document).ready(function() {
  $('.notification').on('click', '.delete', function() {
    console.log("closed")
    $(this).parent().hide()
  })
});
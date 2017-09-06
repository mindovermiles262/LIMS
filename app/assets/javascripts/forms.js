$(document).ready(function() { 
  $('form').on('click', '.remove-link', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.form-fields').hide();
    return event.preventDefault();
  });
});

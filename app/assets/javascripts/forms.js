$(document).ready(function() { 
  $('form').on('click', '.remove-link', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.form-fields').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    console.log("add clicked");
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
});

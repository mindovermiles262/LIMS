$( document ).on('turbolinks:load', function() {
  // Remove test fields to project
  $('form').on('click', '.remove-link', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).prev('.select-menu').val('0')
    return event.preventDefault();
  });

  // Add test fields to project
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  // Mark project as received
  $('#received input[type=submit]').remove()
  $('#received input[type=checkbox]').click(function() {
    $(this).parent('form').submit()
  })
});
$( document ).on('turbolinks:load', function() {
  // Removes Sample fields from Projects Form
  $('form').on('click', '.destroy_fields', function() {
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.fieldset').hide()
    event.preventDefault()
  })

  // Adds Test fields to Samples form
  $('form').on('click', '.add_fields', function() {
    time = new Date().getTime()
    regex = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regex, time))
    event.preventDefault()
  })

  // Hides Available Tests Table if none available
  $('#available_tests_section').each(function() {
    if($(this).find('tr').children('td').length < 1) {
      $(this).hide()
    }
  })

  // Remove Table Rows from Batch
  $('table').on('click', '.destroy_row', function() {
    $('#available_tests_section').show()
    var row = $(this).parents('tr:first');
    $(this).prev('input[type=hidden]').val('nil')
    $('#append_unbatched_tests').append(row)
    $(row).find('a').attr('class', 'add_test_to_batch')
    $(row).find('i').attr("aria-hidden", "true")
    $(row).find('i').attr("class", "fa fa-plus")
    event.preventDefault()
  })
});
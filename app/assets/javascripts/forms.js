$( document ).on('turbolinks:load', function() {
  $('form').on('click', '.remove-link', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).prev('.select-menu').val('0')
    // $(this).closest('.form-fields').hide();
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

/*
<div class="form-group fields">
          
<div class="form-fields">
  <div class="row">
    <label class="col-md-2" for="project_tests_attributes_0_test_method_id">Test Method</label>
    <div class="col-md-6">
      <select name="project[tests_attributes][0][test_method_id]" id="project_tests_attributes_0_test_method_id">
      <option value=""></option>
      <option value="1">APC PF</option>
      <option value="2">RY&amp;M PF</option></select>
    </div>
    <a class="remove-link col-md-2" href="#">Delete</a>
  </div>
</div>
</div>  
*/
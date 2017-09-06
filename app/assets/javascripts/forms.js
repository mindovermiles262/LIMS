$(document).ready(function() {
  $( ".remove-link" ).click(function() {
    $(this).parent().find("input[type=hidden]").value = "1";
    $(this).closest(".form-fields").hide();
    $(this).find(".method-select").children().empty()
  });
});
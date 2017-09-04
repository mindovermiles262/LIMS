$( document ).ready(function() {
  $( ".remove-link" ).click(function() {
    console.log("click start");
    $(this).parent().find("input[type=hidden]").value = "1";
    $(this).closest(".form-fields").hide();
    console.log("click end");
  });
})
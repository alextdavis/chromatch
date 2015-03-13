$(function() {
   $(".submit-btn").click(function(e) {
       e.preventDefault();

       $(this).closest("form").first().submit();
   })
});
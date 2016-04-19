$(function(){
  $('#dynamic_select').on('change', function () {
    var url = $(this).val(); // get selected value
    if (url) { 
      window.location = 'city/' . url; // redirect
    }
    return false;
  });
});
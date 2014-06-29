$(document).ready(function(){
  $('#sessions_panel').on('change', 'select', function(e) {
    $(e.target).parent('form').submit();
  });
});

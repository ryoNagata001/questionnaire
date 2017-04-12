jQuery(document).ready(function($){
  jQuery('.category').click(function(){
    jQuery('.active').slideUp();
    jQuery('.active').removeClass('active');
    var clickedIndex = jQuery('.category').index(jQuery(this));
    jQuery('.question-form').eq(clickedIndex).addClass('active');
    jQuery('.active').slideDown();
  });
});

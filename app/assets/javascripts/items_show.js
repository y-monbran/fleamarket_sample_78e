$(document).on('turbolinks:load', ()=> {
  $(".Item__select--photo").click(function(){
   var $thisImg = $(this).attr("src");
   var $thisAlt = $(this).attr("alt");
   $(".Item__content--photo").attr({src:$thisImg,alt:$thisAlt});
  });
});
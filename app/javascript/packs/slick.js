$(document).on('turbolinks:load', function() {
  $(".slider").slick({
    arrows: false,
    autoplay: true,
    adaptiveHeight: true,
    centerMode: true,
    centerPadding: "25%",
    dots: true,
    variableWidth: false,
  });
  $('.slick01').on('beforeChange', function(){
    $('.slick-current').removeClass('is--active');
  });
  $('.slick01').on('afterChange', function(){
    $('.slick-current').addClass('is--active');
  });
  $('.slider-image img').click(function(){
    $("#grayDisplay").html($(this).prop("outerHTML"));
    //そして、fadeInで表示する。
    $("#grayDisplay").fadeIn(200);
    return false;
  });
  $("#grayDisplay").click(function () {
    // 非表示にする
    $("#grayDisplay").fadeOut(200);
    return false;
  });
});
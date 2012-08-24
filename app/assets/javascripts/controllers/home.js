OpenUp.home = {
  
  init: function(){
    console.log("using home");
    $("[data-scroll-to]").click(function(){
       OpenUp.home.goToByScroll($(this).data('scroll-to')); 
    });   
    
    //$(window).scroll(OpenUp.home.resizeHeader);
    
    // OpenUp.home.resizeHeader();    

  },


  goToByScroll: function(id){
    $('html,body').animate({scrollTop: $("#"+id).offset().top - 95},'fast');
  },

  resizeHeader: function(){
      var pos = $(window).scrollTop();
      
      if (pos >= 60) {
          $("body").addClass('fixed-header')
      }else{
          $("body").removeClass('fixed-header')        
      }
  },

  index: function(){
    console.log("using index");      

    

    $.getJSON('/home/stats.json', function(data) {
      // console.log(data)
      var values = [data.total_fulfilled, data.total_denied, data.total_pending],
          labels = ['Fulfilled', 'Denied', 'Pending'],
          colors = [ '#00A79B' , '#bf272d', '#D8DF21'];
      
      Raphael("pie-chart", 700, 700).pieChart(300, 300, 150, values, labels, colors, "#fff");



      console.log($(".pie-chart-slice").length);

      $(".pie-chart-slice").click(function(){
        console.log($(this).attr("href"));
        window.location = $(this).attr("href");
        return false;
      });


    });


  }  


}

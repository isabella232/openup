OpenUp.home = {
  
  init: function(){
    console.log("using home");
    $("[data-scroll-to]").click(function(){
       OpenUp.home.goToByScroll($(this).data('scroll-to')); 
    });   
    
    $(window).scroll(OpenUp.home.resizeHeader);
    
    OpenUp.home.resizeHeader();    

    $("select").chosen();
    $("select").chosen({allow_single_deselect:true});    
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
  }

  index: function(){
    console.log("using index");      
    var values = [45, 30, 25],
        labels = ['Fulfilled', 'Complete', 'Something'],
        colors = ['#00A79B', '#D8DF21', '#bf272d'];
    
    Raphael("pie-chart", 700, 700).pieChart(300, 300, 150, values, labels, colors, "#fff");

  }  


}

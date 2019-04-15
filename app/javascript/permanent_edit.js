$(document).ready(function () {

        $(document).on("click","#submit-button",submitfunction);
        var submitfunction=function(){
  $.ajax({
    type:'GET',
    url:'/permanent_edit',
    data: { selectingCommand : document.getElementById("CommandSelect"); 
          },
    success:function(){
      //I assume you want to do something on controller action execution success?
      $(this).addClass('done');
    }
  });
}
        
        /*$("submitButton").click(function(){
            $id_selected = parseInt($(".cycle_week").val()) * 7 + parseInt($(".cycle_day").val())
            
            $.get( "/controller/action.json", { id: id_selected } )
  .done(view_dishes( id ) {
    // Access your data here
  });
        });*/
        
    });
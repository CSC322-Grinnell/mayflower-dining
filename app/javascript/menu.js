
    
    function formatDate(date) {
      console.log("Entereed:");
        var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
    
      
      
    function changeDate() {
      var mydate = document.getElementById("datePicker").value;
      
      window.location.href = '../menu/' + mydate;
      
      
    }
    
    
    function changeToTomorrow () {
      
      var d = new Date();
      var tom = new Date();
      tom.setDate(d.getDate()+1);
      
      window.location.href = '../menu/' + formatDate(tom);
    }
    
    function changeToToday () {
      
      var d = new Date();
      //document.getElementById("datePicker").value = formatDate(d);
      
      window.location.href = '../menu/' + formatDate(d);
    }
    
    
    
    window.addEventListener('DOMContentLoaded', (event) => {
        
        document.getElementById("tomText").addEventListener("click", changeToTomorrow);
        document.getElementById("todText").addEventListener("click", changeToToday);
        document.getElementById("datePicker").onchange = function() {changeDate()};
    });

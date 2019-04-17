    window.onload = function() {changeDate()};
    
    function changeDate() {
      
      var url = window.location.href.slice(-4);
      if(url == "menu" || url == "enu/") {
        
      }
      else {
        url = window.location.href.slice(-10);
        
        
        var d = new Date(url+"T12:00:00-05:00");
        
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
        
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day ;
        
        
        
      document.getElementById("datePicker").value = [year, month, day].join('-');
      }
      
      var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      var weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

      document.getElementById("headerDate").innerHTML = "Menu for " + weekdays[d.getDay()] + " " + months[d.getMonth()] + " " + day;
      
    }
    window.onload = function() {changeDate()};
    
    function changeDate() {
      // go to a new date and display the menu for that day
      var url = window.location.href.slice(-4); // retrieve date from the url
      if(url == "menu" || url == "enu/" || url == "temp" || url == "emp/") {
        // does nothing (yet);
      }
      else {
        url = window.location.href.slice(-10); // retrieve date from the url
        var d = new Date(url+"T12:00:00-05:00"); // set time;
        
        // set the complete target date;
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
        
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day ;
        
      document.getElementById("datePicker").value = [year, month, day].join('-'); //set url parameters
      }
      
      // set arrays of text date variables
      var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      var weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
      // set url;
      document.getElementById("headerDate").innerHTML = "Menu for " + weekdays[d.getDay()] + " " + months[d.getMonth()] + " " + day;
    }
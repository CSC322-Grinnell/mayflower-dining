    window.onload = function() {changeDate()};
    
    function changeDate() {
      console.log("Came here");
      var url = window.location.href.slice(-4);
      if(url == "menu" || url == "enu/") {
        
      }
      else {
        url = window.location.href.slice(-10);
      var d = new Date(url),
        month = '' + (d.getMonth() + 1),
        day = '' + (d.getDate() + 1),
        year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

      document.getElementById("datePicker").value = [year, month, day].join('-');
      }
      console.log(d.getMonth() + " "+ d.getDate());
      var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      
      document.getElementById("headerDate").innerHTML = "Menu for " + months[d.getMonth()] + " " + day;
      
    }
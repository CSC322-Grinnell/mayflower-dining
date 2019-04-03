    window.onload = function() {pickerUpdate()};

    function pickerUpdate() {
      var url= window.location.href.slice(-4);
      if(url == "menu" || url == "enu/") {
        document.getElementById("datePicker").value = formatDate(new Date());
      }
      else {
        // Format Date to put into datepicker
        url = window.location.href.slice(-10);
      var d = new Date(url),
        month = '' + (d.getMonth() + 1),
        day = '' + (d.getDate() + 1),
        year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

      document.getElementById("datePicker").value = [year, month, day].join('-');
      }
      
    }
    
    function formatDate(date) {
      
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
      document.getElementById("headerDate").innerHTML = "Menu for " + mydate;
      document.getElementById("datePicker").innerHTML = formatDate(mydate);
      
      window.location.href = '../menu/' + mydate;
      
      
    }
    
    
    function changeToTomorrow () {
      
      var d = new Date();
      var tom = new Date();
      tom.setDate(d.getDate()+1);
      var weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Sunday"];
      var month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      
      
      
      document.getElementById("datePicker").value = formatDate(tom);
      window.location.href = '../menu/' + document.getElementById("datePicker").value;
      document.getElementById("headerDate").innerHTML = "Menu for Tomorrow, " + weekday[tom.getDay()] ;
    }
    
    function changeToToday () {
      document.getElementById("headerDate").innerHTML = "Menu for Today";
      var d = new Date();
      document.getElementById("datePicker").value = formatDate(d);
      window.location.href = '../menu/' + document.getElementById("datePicker").value;
    }
    
    
    
    window.addEventListener('DOMContentLoaded', (event) => {
        
        document.getElementById("tomText").addEventListener("click", changeToTomorrow);
        document.getElementById("todText").addEventListener("click", changeToToday);
        document.getElementById("datePicker").onchange = function() {changeDate()};
    });

    
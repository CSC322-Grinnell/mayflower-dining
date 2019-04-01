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
      //var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      //var str = months[mydate.getMonth()] + ' ' + mydate.getFullYear();
      document.getElementById("headerDate").innerHTML = "Menu for " + mydate;
      window.location.href = '../menu/' + mydate;
      
      // SEND A GET REQUEST TO YOUR HTML WITH THE DATE
      // THIS WILL RETURN A SAME HTML PAGE BUT WITH NEW DISHES ADDED ACCORDING TO DATE
      
    }
    
    
    function changeToTomorrow () {
      document.getElementById("headerDate").innerHTML = "Menu for Tomorrow";
      var d = new Date();
      var tom = new Date();
      tom.setDate(d.getDate()+1);
      document.getElementById("datePicker").value = formatDate(tom);
      window.location.href = '../menu/' + document.getElementById("datePicker").value;
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

    
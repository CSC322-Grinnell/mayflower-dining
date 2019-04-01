
/*document.getElementById('datePicker').value = new Date().toDateInputValue();

Date.prototype.toDateInputValue = (function() {
    var local = new Date(this);
    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
    return local.toJSON().slice(0,10);
});*/
    
    function changeDate() {
      var mydate = document.getElementById("datePicker").value;
      //var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      //var str = months[mydate.getMonth()] + ' ' + mydate.getFullYear();
      document.getElementById("headerDate").innerHTML = "Menu for " + mydate;
      
    }
    
    function changeToTomorrow () {
      document.getElementById("headerDate").innerHTML = "Menu for Tomorrow";
    }
    
    function changeToToday () {
      document.getElementById("headerDate").innerHTML = "Menu for Today";
    }
    
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("tomText").addEventListener("click", changeToTomorrow);
        document.getElementById("todText").addEventListener("click", changeToToday);
        document.getElementById("datePicker").onchange = function() {changeDate()};
    });

    
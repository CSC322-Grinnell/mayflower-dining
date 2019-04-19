function changeURL () {
      
      var week = document.getElementById("cycle_week").value;
      var day = document.getElementById("cycle_day").value;
      var id = parseInt(week) * 7 + parseInt(day); 
      window.location.href = '../permanent_edit/' + id ;
    }
    
    
    
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("submitButton").addEventListener("click", changeURL);
    });
function changeURL () {
      var week = document.getElementById("cycle_week").value;
      var day = document.getElementById("cycle_day").value;
      var id = parseInt(week) * 7 + parseInt(day); 
      window.location.href = '../permanent_edit/' + id ;
    }
    
    function prevDayInCycle () {
        var link_array = window.location.pathname.split("/");
        var id = link_array[link_array.length - 1];
        id--;
        if (id < 1){
            id = id + 49;
        }
        window.location.href = window.location.origin + "/permanent_edit/" + id;
    }
    
    function nextDayInCycle () {
        console.log("going to next day");
        var link_array = window.location.pathname.split("/");
        var id = link_array[link_array.length - 1];
        id++;
        if (id > 49){
            id = id - 49;
        }
        window.location.href = window.location.origin + "/permanent_edit/" + id;
    }
    
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("submitButton").addEventListener("click", changeURL);
        document.getElementById("previousButton").addEventListener("click", prevDayInCycle);
        document.getElementById("nextButton").addEventListener("click", nextDayInCycle);
    });
    
    
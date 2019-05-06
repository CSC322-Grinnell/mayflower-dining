function changeURL () {
      var week = document.getElementById("cycle_week").value;
      var day = document.getElementById("cycle_day").value;
      var url = window.location.href.slice(-14);
      if (url == "permanent_edit" || url == "ermanent_edit/") {
          window.location.href = '../permanent_edit/' + parseInt(week) + '/' + parseInt(day) ;
      }
      else {
          window.location.href = '../' + parseInt(week) + '/' + parseInt(day) ;
      }
      
    }
    
    function prevDayInCycle () {
        var link_array = window.location.pathname.split("/");
        var arr_len = link_array.length;
        var max_days = 7;
        var max_week = 6;
        var week = link_array[arr_len - 2]
        var day = link_array[arr_len - 1];
        day--;
        if (day < 1 && week == 0){
            day = max_days;
            week = max_week;
        }
        else if (day < 1) {
            day = max_days;
            week--;
        }
        window.location.href = window.location.origin + "/permanent_edit/" + week + "/" + day;
    }
    
    function nextDayInCycle () {
        
        var link_array = window.location.pathname.split("/");
        var arr_len = link_array.length;
        var max_days = 7;
        var max_week = 6;
        var week = link_array[arr_len - 2]
        var day = link_array[arr_len - 1];
        
        day++;
        
        if (day > max_days && week == max_week){
            day = 1;
            week = 0;
        } 
        else if (day > max_days) {
            day = 1;
            week++;
        }
        window.location.href = window.location.origin + "/permanent_edit/" + week + "/"+ day;
    }
    
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("submitButton").addEventListener("click", changeURL);
        document.getElementById("previousButton").addEventListener("click", prevDayInCycle);
        document.getElementById("nextButton").addEventListener("click", nextDayInCycle);
    });
    
    
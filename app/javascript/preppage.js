// This javascript file is not functioning yet.
// We hope to find a way to store the checked data, so that after refreshing or closing this page,
// the kitchen can still see which items are completed.
// LocalStorage doesn't seem to work the way we expected.

console.log(selected);

function saveCheck (e) {
    console.log(e);
    let id_current = e.target.id;
    var check_box = document.getElementById(id_current);
    if (check_box.checked) {
        localStorage.setItem('id_current', true);
    }
}

function load () {
    saveCheck();
    var checked = JSON.parse(localStorage.getItem('check_box'));
    if (checked == true) {
        document.getElementsByClassName("checkBox").checked = true;
    }
}

window.addEventListener('DOMContentLoaded', (event) =>{
    load();
    let itemArr = document.getElementsByClassName("checkBox");
    for (let i=0; i<itemArr.length; i++) {
        itemArr[i].addEventListener("click", saveCheck);
    }
});
// This javascript file is not functioning yet.
// We hope to find a way to store the checked data, so that after refreshing or closing this page,
// the kitchen can still see which items are completed.
// LocalStorage doesn't seem to work the way we expected.
<input id="checkBox" type="checkbox">
<script>
$('#checkBox').click(function(e){
	if (e.target.checked) {
  	  localStorage.checked = true;
} else {
  	  localStorage.checked = false;
  }
})
 
$( document ).ready(function() {
  
	document.querySelector('#checkBox').checked = localStorage.checked
  
});
</script>
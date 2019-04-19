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
console.log(hello);
var selected = new Array();
$('#table input[type="checkbox"]:checked').each(function() {
    selected.push($(this).attr('id'));
});

console.log(selected);
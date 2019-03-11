$(document).ready(function() {
    var var_wrapper = $(".ingredient_list"); // fields wrapper
    var add_ingredient_button = $(".add_ingredient"); //add_ingredient button
    
    $(add_ingredient_button).click(function(e) {
        console.log("clicked");
        e.preventDefault();
        var one_ingredient = '<div class ="form-group-row">'+
        '<input type="text" class="col-sm-2 form-control" id="ingredient_name" placeholder="Ingredient"> </input>'+
        '<input type="text" class="col-sm-2 form-control" id="ingredient_amount" placeholder="Amount"> </input>'+
        '<button class="remove_field">Remove</button></div>';
        $(var_wrapper).append(one_ingredient);
    });
});
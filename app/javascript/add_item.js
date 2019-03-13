$(document).ready(function() {
    var var_wrapper = $(".new_dish"); // fields wrapper
    var add_ingredient_button = $(".add_ingredient"); //add_ingredient button
    var save_ingredient_button = $(".save_ingredient"); //save_ingredient button
    
    $(add_ingredient_button).click(function(e) {
        console.log("clicked add_ingredient_button");
        e.preventDefault();
        var one_ingredient = '<div class="form-group row" id="new_ing">'+
        '<input type="text" class="col-sm-2 form-control" id="ingredient_name" placeholder="Ingredient"> </input>'+
        '<input type="text" class="col-sm-2 form-control" id="ingredient_amount" placeholder="Amount"> </input>'+
        '<button class="remove-me">Remove</button></div>';
        $(var_wrapper).append(one_ingredient);
        
        $('.remove-me').click(function(e) {
            e.preventDefault();
            $(this).remove();
            $('.new_ing').remove();
        });
    });
    
    $(save_ingredient_button).click(function(e) {
        console.log("clicked save_ingredient_button");
        e.preventDefault();
        $(".ingredient_list").trigger('submit.rails');
    });
});
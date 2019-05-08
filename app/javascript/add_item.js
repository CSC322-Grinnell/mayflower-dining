$(document).ready(function() {
    var var_wrapper = $(".new_dish"); // fields wrapper
    var insert_before_this = $(".insert_before_this"); // fields wrapper
    var add_ingredient_button = $(".add_ingredient"); //add_ingredient button
    var count = 0;
    
    $(add_ingredient_button).click(function(e) {
        count++; // count up for each ingredient;
        console.log("clicked add_ingredient_button "+count); // for debugging purposes
        e.preventDefault();
        
        //creating the new ingredient
        var one_ingredient = `<div class="form-group row" id="new_ing_${count}" ">`+
        `<input required type="text" class="col-sm-2 form-control" id="ingredient_name" name="ingredient[${count}][name]" placeholder="Ingredient"> </input>`+
        `<input required type="text" class="col-sm-2 form-control" id="ingredient_amount"  name="ingredient[${count}][amount]" placeholder="Amount"> </input>`+
        `<button class="remove-me btn btn-danger" item=${count}>Remove</button></div>`;
        $( one_ingredient).insertBefore(insert_before_this); 
        
        //Delete button for each ingredient
        $('.remove-me').click(function(e) {
            e.preventDefault();
            let theThingToDelete = $(this).attr('item');
            console.log(theThingToDelete);
            $(`#new_ing_${theThingToDelete}`).remove();
        });
    });
});
$(document).ready(function() {
    var var_wrapper = $(".new_dish"); // fields wrapper
    var insert_before_this = $(".insert_before_this"); // fields wrapper
    var add_ingredient_button = $(".add_ingredient"); //add_ingredient button
    var save_ingredient_button = $(".save_ingredient"); //save_ingredient button
    
    var count = 0;
    
    $.validate({
        lang: 'en'
    });
    
    $(add_ingredient_button).click(function(e) {
        count++;
        console.log("clicked add_ingredient_button");
        e.preventDefault();
        
        //creating the new ingredient
        var one_ingredient = `<div class="form-group row" id="new_ing_${count}" ">`+
        `<input type="text" class="col-sm-2 form-control" id="ingredient_name" name="ingredient[${count}][name]" placeholder="Ingredient"> </input>`+
        `<input type="text" class="col-sm-2 form-control" id="ingredient_amount"  name="ingredient[${count}][amount]" placeholder="Amount"> </input>`+
        `<button class="remove-me btn btn-danger" item=${count}>Remove</button></div>`;
        $( one_ingredient).insertBefore(insert_before_this); 
        // $(var_wrapper).append(one_ingredient);
        
        //Delete button for each ingredient
        $('.remove-me').click(function(e) {
            e.preventDefault();
            let theThingToDelete = $(this).attr('item');
            console.log(theThingToDelete);
            $(`#new_ing_${theThingToDelete}`).remove();
        });
    });
    
    $(save_ingredient_button).click(function(e) {
        console.log("clicked save_ingredient_button");
        e.preventDefault();
        $(".ingredient_list").trigger('submit.rails');
    });
});
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require best_in_place
#= require jquery.purr
#= require best_in_place.purr

$(document).ready ->
  jQuery(".best_in_place").best_in_place()
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"


// app/javascript/packs/artists.js
$(document).on('load', function() {
    $('#add_tag').click(function(e) {
      e.preventDefault();
      var new_id = new Date().getTime();
      var regexp = new RegExp("new_tagged_items", "g");
      var content = $('#tagged_items_fields_template').html().replace(regexp, new_id);
      $('#tagged_items_fields').append(content);
    });
  });

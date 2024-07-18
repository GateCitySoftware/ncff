# frozen_string_literal: true

module ApplicationHelper

  def stage_css_color_classes
    @stage_css_color_classes ||= begin
      Stage::STAGE_ORDER.zip(repeating_colors_array).to_h
    end
  end

  # makes colors repeat for number of stages
  def repeating_colors_array
    @repeating_colors_array ||= begin
      colors = %w( ncff-teal ncff-blue ncff-orange )
      stage_count = Stage::STAGE_ORDER.count
      loops = (stage_count / colors.count.to_f).ceil
      repeating_colors = colors * loops
      repeating_colors[0..stage_count - 1]
    end
  end

  def artist_stock_image
    images = ["beyonce.jpeg", "bob-dylan.jpeg", "david-bowie.jpeg", "elvis.jpeg", "madonna.jpeg", "michael-jackson.jpeg", "prince.jpeg", "the-beatles.jpeg", "whitney-houston.jpeg"]
    
    @image_index ||= rand(images.length)
    
    image = images[@image_index]
    @image_index = (@image_index + 1) % images.length
    
    image
  end

  def vendor_stock_image
    images = ["res-1.jpeg", "res-2.jpeg", "res-3.jpeg", "res-4.jpeg", "res-5.jpeg", "res-6.jpeg", "res-7.jpeg", "res-8.jpeg", "res-9.jpeg", "res-10.jpeg"]
    
    @vendor_image_index ||= rand(images.length)
    
    image = images[@vendor_image_index]
    @vendor_image_index = (@vendor_image_index + 1) % images.length
    
    image
  end
end




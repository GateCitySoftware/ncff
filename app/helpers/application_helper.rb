# frozen_string_literal: true

module ApplicationHelper
  def stage_css_color_classes
    @stage_css_color_classes ||= Stage::STAGE_ORDER.zip(repeating_colors_array).to_h
  end

  # makes colors repeat for number of stages
  def repeating_colors_array
    @repeating_colors_array ||= begin
      colors = %w[ncff-teal ncff-blue ncff-orange]
      stage_count = Stage::STAGE_ORDER.count
      loops = (stage_count / colors.count.to_f).ceil
      repeating_colors = colors * loops
      repeating_colors[0..stage_count - 1]
    end
  end

  def repeat_colors_by_index(index)
    colors = %w[ncff-teal ncff-blue ncff-orange]
    colors[index % colors.length]
  end
end

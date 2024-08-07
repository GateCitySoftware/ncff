class SaveVendor
  include SuccessBoolean

  def initialize(vendor, params)
    @vendor = vendor
    @params = params
  end

  def call
    tap do
      ActiveRecord::Base.transaction do
        update_vendor_attributes
        update_tags
        update_external_links
        @success = true
      end
      @vendor
    end
  end

  private

  def update_vendor_attributes
    update_param_keys = %w[name description image website phone email address city state]
    @vendor.update!(
      name: @params[:name],
      description: @params[:description],
      image: @params[:image],
      phone: @params[:phone],
      email: @params[:email],
      address: @params[:address],
      city: @params[:city],
      state: @params[:state]
    )
  end

  def update_tags
    return unless @params[:tag_ids]

    new_tag_ids = @params[:tag_ids]
    current_tag_ids = @vendor.tags.pluck(:id)

    tags_to_add = new_tag_ids - current_tag_ids
    tags_to_remove = current_tag_ids - new_tag_ids

    tags_to_add.each do |tag_id|
      next if tag_id == 0 || tag_id.blank? # not sure why I need this, but can fix later

      TaggedItem.create!(taggable: @vendor, tag_id:)
    end

    TaggedItem.where(taggable: @vendor, tag_id: tags_to_remove).destroy_all
  end

  def update_external_links
    external_links = @params[:external_links].to_unsafe_h.reject { |k, v| v.blank? }
    external_links.each do |link_type, url|
      link_type = link_type.to_s.sub('_url', '')

      existing_link = @vendor.external_links.find_by(link_type:)

      if url.present?
        if existing_link
          existing_link.update(url:)
        else
          @vendor.external_links.create(link_type:, url:)
        end
      elsif existing_link
        existing_link.destroy
      end
    end
  end
end

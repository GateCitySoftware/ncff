class SaveArtist
  include SuccessBoolean

  def initialize(artist, params)
    @artist = artist
    @params = params
  end

  def call
    tap do
      ActiveRecord::Base.transaction do
        update_artist_attributes
        update_tags
        update_external_links
        @success = true
      end
      @artist
    end
  end

  private

  def update_artist_attributes
    @artist.update!(name: @params[:name], bio: @params[:bio])
  end

  def update_tags
    return unless @params[:tag_ids]

    new_tag_ids = @params[:tag_ids].map(&:to_i)
    current_tag_ids = @artist.tags.pluck(:id)

    tags_to_add = new_tag_ids - current_tag_ids
    tags_to_remove = current_tag_ids - new_tag_ids

    tags_to_add.each do |tag_id|
      next if tag_id == 0 || tag_id.blank? # not sure why I need this, but can fix later

      TaggedItem.create!(taggable: @artist, tag_id:)
    end

    TaggedItem.where(taggable: @artist, tag_id: tags_to_remove).destroy_all
  end

  def update_external_links
    @params[:external_links].each do |link_type, url|
      link_type = link_type.to_s.sub('_url', '')

      existing_link = @artist.external_links.find_by(link_type:)
      binding.pry

      if url.present?
        if existing_link
          existing_link.update(url:)
        else
          @artist.external_links.create(link_type:, url:)
        end
      elsif existing_link
        existing_link.destroy
      end
    end
  end
end

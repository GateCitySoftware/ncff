class SaveArtist
  include SuccessBoolean

  def initialize(artist, params)
    @artist = artist
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      update_artist_attributes
      update_tags
      @success = true
    end
    @artist
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
      TaggedItem.create!(artist: @artist, tag_id:)
    end

    TaggedItem.where(artist: @artist, tag_id: tags_to_remove).destroy_all
  end
end

class HomeController < ApplicationController
  layout false, only: [:index_v3]

  def index
    @data = OpenStruct.new(
      hero_images:,
      statistics:,
      offerings:,
      artists:,
      sponsors:,
      stages:,
      schedule_days:,
      ticket_types:,
      testimonials:,
      gallery_items:,
      attendee_avatars:,
      footer_links:,
      social_links:
    )
  end

  def index_v3
    @data = OpenStruct.new(
      hero_images:,
      statistics:,
      offerings:,
      artists:,
      sponsors:,
      stages:,
      schedule_days:,
      ticket_types:,
      testimonials:,
      gallery_items:,
      attendee_avatars:,
      footer_links:,
      social_links:
    )
  end

  def gcs_landing_page
  end

  def landing_conference_example
  end

  private

  def stage_schedules
    @stage_schedules ||= StageSchedules.generate
  end

  def stages
    stage_schedules[:stages]
  end

  def schedule_days
    stage_schedules[:schedule_days]
  end

  def hero_images
    [
      OpenStruct.new(src: 'assets/ncff-headliner-war-and-treaty.png', alt: 'Image of Performing Artist: War & Treaty',
                     name: 'War & Treaty'),
      OpenStruct.new(src: 'assets/ncff-headliner-mipso.png', alt: 'Image of Performing Artist: Mipso', name: 'Mipso'),
      OpenStruct.new(src: 'assets/ncff-headeliner-los-lonely-boys.png',
                     alt: 'Image of Performing Artist: Los Lonely Boys', name: 'Los Lonely Boys')
    ]
  end

  def statistics
    [
      OpenStruct.new(value: '100,000+', label: 'Attendees'),
      OpenStruct.new(value: '50+', label: 'Artists'),
      OpenStruct.new(value: '3', label: 'Days of Music'),
      OpenStruct.new(value: '10', label: 'Years Running')
    ]
  end

  def offerings
    [
      OpenStruct.new(
        id: 'offering1',
        name: 'Artists',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      ),
      OpenStruct.new(
        id: 'offering1',
        name: 'Stages',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      ),
      OpenStruct.new(
        id: 'offering1',
        name: 'Eat & Drink',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      ),
      OpenStruct.new(
        id: 'offering1',
        name: 'Shop & Do',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      )
    ]
  end

  def artists
    [
      OpenStruct.new(
        name: 'Artist Name',
        genres: 'Folk, Rock',
        card_image: 'path/to/artist_image.jpg'
      )
    ]
  end

  def sponsors
    [
      OpenStruct.new(
        name: 'Sponsor Name',
        description: 'Sponsor description',
        logo_light: 'path/to/logo_light.png',
        logo_dark: 'path/to/logo_dark.png'
      )
    ]
  end

  def ticket_types
    [
      OpenStruct.new(
        name: 'FREE',
        description: 'Free ticket description',
        price: 0,
        col_width: 4,
        bg_class: 'bg-secondary',
        bg_image: nil,
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      )
    ]
  end

  def testimonials
    [
      OpenStruct.new(
        name: 'John Doe',
        avatar: 'path/to/avatar.jpg',
        rating: 5,
        content: 'Testimonial content here'
      )
    ]
  end

  def gallery_items
    [
      OpenStruct.new(
        col_class: 'col-md-4',
        full_image: 'path/to/full_image.jpg',
        thumbnail: 'path/to/thumbnail.jpg',
        alt: 'Image description'
      )
    ]
  end

  def attendee_avatars
    [
      'path/to/avatar1.jpg',
      'path/to/avatar2.jpg',
      'path/to/avatar3.jpg'
    ]
  end

  def footer_links
    [
      OpenStruct.new(url: '#', text: 'About'),
      OpenStruct.new(url: '#', text: 'Contact')
    ]
  end

  def social_links
    [
      OpenStruct.new(platform: 'facebook', url: '#'),
      OpenStruct.new(platform: 'twitter', url: '#'),
      OpenStruct.new(platform: 'instagram', url: '#')
    ]
  end
end

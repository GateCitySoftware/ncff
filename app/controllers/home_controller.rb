class HomeController < ApplicationController
  layout false, only: %i[index_v3 list_view item_view]

  def landing_page
    @data = {
      hero_images:,
      statistics:,
      offerings:,
      artists:,
      headliner_artists:,
      sponsors:,
      stages:,
      schedule_days:,
      ticket_types:,
      testimonials:,
      gallery_items:,
      attendee_avatars:,
      footer_links:,
      social_links:
    }

    render 'home/landing_page/base'
  end

  def list_view
  end

  def item_view
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
      { src: 'assets/ncff-headliner-war-and-treaty.png', alt: 'Image of Performing Artist: War & Treaty',
        name: 'War & Treaty' },
      { src: 'assets/ncff-headliner-mipso.png', alt: 'Image of Performing Artist: Mipso', name: 'Mipso' },
      { src: 'assets/ncff-headeliner-los-lonely-boys.png',
        alt: 'Image of Performing Artist: Los Lonely Boys', name: 'Los Lonely Boys' }
    ]
  end

  def statistics
    [
      { value: '100,000+', label: 'Attendees' },
      { value: '50+', label: 'Artists' },
      { value: '3', label: 'Days of Music' },
      { value: '10', label: 'Years Running' }
    ]
  end

  def offerings
    [
      {
        id: 'offering1',
        name: 'Artists',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      },
      {
        id: 'offering1',
        name: 'Stages',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      },
      {
        id: 'offering1',
        name: 'Eat & Drink',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      },
      {
        id: 'offering1',
        name: 'Shop & Do',
        description: 'Description of music offering',
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      }
    ]
  end

  def artists
    all_artists.reject { |artist| artist[:headliner] }.shuffle
  end

  def headliner_artists
    all_artists.select { |artist| artist[:headliner] }.shuffle
  end

  def all_artists
    @all_artists ||= Artist.all.map do |artist|
      {
        name: artist.name,
        genres: artist.genres,
        image: artist.primary_image(size: 'medium'),
        headliner: artist.headliner?
      }
    end
  end

  def sponsors
    [
      {
        name: 'Sponsor Name',
        description: 'Sponsor description',
        logo_light: 'path/to/logo_light.png',
        logo_dark: 'path/to/logo_dark.png'
      }
    ]
  end

  def ticket_types
    [
      {
        name: 'FREE',
        description: 'Free ticket description',
        price: 0,
        col_width: 4,
        bg_class: 'bg-secondary',
        bg_image: nil,
        features: ['Feature 1', 'Feature 2', 'Feature 3']
      }
    ]
  end

  def testimonials
    [
      {
        name: 'John Doe',
        avatar: 'path/to/avatar.jpg',
        rating: 5,
        content: 'Testimonial content here'
      }
    ]
  end

  def gallery_items
    [
      {
        col_class: 'col-md-4',
        full_image: 'path/to/full_image.jpg',
        thumbnail: 'path/to/thumbnail.jpg',
        alt: 'Image description'
      }
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
      { url: '#', text: 'About' },
      { url: '#', text: 'Contact' }
    ]
  end

  def social_links
    [
      { platform: 'facebook', url: '#' },
      { platform: 'twitter', url: '#' },
      { platform: 'instagram', url: '#' }
    ]
  end
end

class HomeController < ApplicationController
  def index
    @data = OpenStruct.new(
      # Hero section
      hero_images: [
        OpenStruct.new(src: 'assets/ncff-headliner-war-and-treaty.png', alt: 'Image of Performing Artist: War & Treaty',
                       name: 'War & Treaty'),
        OpenStruct.new(src: 'assets/ncff-headliner-mipso.png', alt: 'Image of Performing Artist: Mipso',
                       name: 'Mipso'),
        OpenStruct.new(src: 'assets/ncff-headeliner-los-lonely-boys.png', alt: 'Image of Performing Artist: Los Lonely Boys',
                       name: 'Los Lonely Boys')
        # Add more hero images as needed
      ],

      # Statistics section
      statistics: [
        OpenStruct.new(value: '100,000+', label: 'Attendees'),
        OpenStruct.new(value: '50+', label: 'Artists'),
        OpenStruct.new(value: '3', label: 'Days of Music'),
        OpenStruct.new(value: '10', label: 'Years Running')
      ],

      # Offerings section
      offerings: [
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
        # Add more offerings as needed
      ],

      # Artists section
      artists: [
        OpenStruct.new(
          name: 'Artist Name',
          genres: 'Folk, Rock',
          card_image: 'path/to/artist_image.jpg'
        )
        # Add more artists as needed
      ],

      # Sponsors section
      sponsors: [
        OpenStruct.new(
          name: 'Sponsor Name',
          description: 'Sponsor description',
          logo_light: 'path/to/logo_light.png',
          logo_dark: 'path/to/logo_dark.png'
        )
        # Add more sponsors as needed
      ],

      # Schedule section
      schedule_days: [
        OpenStruct.new(
          name: 'Friday',
          events: [
            OpenStruct.new(
              time_range: '10:00 AM - 11:00 AM',
              title: 'Event Title',
              description: 'Event description',
              artists: [
                OpenStruct.new(name: 'Artist Name', avatar: 'path/to/artist_avatar.jpg')
                # Add more artists for the event
              ]
            )
            # Add more events for the day
          ]
        )
        # Add more days (Saturday, Sunday)
      ],

      # Tickets section
      ticket_types: [
        OpenStruct.new(
          name: 'FREE',
          description: 'Free ticket description',
          price: 0,
          col_width: 4,
          bg_class: 'bg-secondary',
          bg_image: nil,
          features: ['Feature 1', 'Feature 2', 'Feature 3']
        )
        # Add more ticket types (VIP, General Admission)
      ],

      # Testimonials section
      testimonials: [
        OpenStruct.new(
          name: 'John Doe',
          avatar: 'path/to/avatar.jpg',
          rating: 5,
          content: 'Testimonial content here'
        )
        # Add more testimonials
      ],

      # Gallery section
      gallery_items: [
        OpenStruct.new(
          col_class: 'col-md-4',
          full_image: 'path/to/full_image.jpg',
          thumbnail: 'path/to/thumbnail.jpg',
          alt: 'Image description'
        )
        # Add more gallery items
      ],

      # Contact form section
      attendee_avatars: [
        'path/to/avatar1.jpg',
        'path/to/avatar2.jpg',
        'path/to/avatar3.jpg'
      ],

      # Footer section
      footer_links: [
        OpenStruct.new(url: '#', text: 'About'),
        OpenStruct.new(url: '#', text: 'Contact')
        # Add more footer links
      ],

      social_links: [
        OpenStruct.new(platform: 'facebook', url: '#'),
        OpenStruct.new(platform: 'twitter', url: '#'),
        OpenStruct.new(platform: 'instagram', url: '#')
        # Add more social links
      ]
    )
  end

  def gcs_landing_page
  end
end

require 'faker'

class VendorGenerator
  CATEGORIES = {
    eat_drink: 'Eat & Drink',
    shop_do: 'Shop & Do',
    activation: 'Activation'
  }.freeze

  def initialize(category)
    unless CATEGORIES.key?(category)
      raise ArgumentError,
            "Invalid category. Must be one of: #{CATEGORIES.keys.join(', ')}"
    end

    @category = category
  end

  def call
    {
      name: generate_name,
      description: generate_description,
      category: @category
    }
  end

  private

  def generate_name
    case @category
    when :eat_drink
      "#{Faker::Restaurant.name} #{Faker::Company.suffix}"
    when :shop_do
      "#{Faker::Commerce.brand} #{Faker::Company.industry}"
    when :activation
      "#{Faker::Company.name} #{Faker::Company.industry}"
    end
  end

  def generate_description
    case @category
    when :eat_drink
      "#{Faker::Restaurant.description} Our #{Faker::Restaurant.type} " \
      "specializes in #{Faker::Food.ethnic_category} cuisine, featuring our famous " \
      "#{Faker::Food.dish}. With a #{Faker::Restaurant.review}, we pride ourselves on " \
      "our #{Faker::Coffee.blend_name} coffee and extensive #{Faker::Beer.brand} beer selection."
    when :shop_do
      "Discover #{Faker::Commerce.product_name.pluralize} at our #{Faker::Company.buzzword} " \
      "#{Faker::Company.industry} store. We offer a wide range of #{Faker::Commerce.department(max: 3)} " \
      "products, including our bestselling #{Faker::Commerce.product_name}. " \
      "Our knowledgeable staff provides #{Faker::Company.bs} services to enhance your shopping experience."
    when :activation
      "Experience #{Faker::Company.catch_phrase} with our #{Faker::Company.buzzword} " \
      "#{Faker::Company.industry} solutions. We specialize in #{Faker::Company.bs}, " \
      "offering innovative #{Faker::Hacker.noun} strategies to #{Faker::Company.buzzword} " \
      "your business. Our team of experts utilizes cutting-edge #{Faker::Hacker.adjective} " \
      'technology to deliver measurable results.'
    end
  end
end

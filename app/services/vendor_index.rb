class VendorIndex
  DATA = Struct.new(:page_name, :vendors, :filter_category, :filter_name, :slug)

  def self.all(category, option, unapproved_listings = false)
    new(category, option, unapproved_listings).call
  end

  def initialize(category, option, unapproved_listings)
    @category = category
    @option = option
    @unapproved_listings = unapproved_listings
  end

  def call
    DATA.new(
      page_name,
      vendors.includes(:tags, :uploads),
      @category,
      filter_name,
      slug
    )
  end

  private

  def page_name
    return 'Unapproved Listings' if @unapproved_listings

    Vendor::CATEGORIES[@category.to_sym]
  end

  def vendors
    return all_unapproved_vendors if @unapproved_listings

    case @category
    when 'eat_drink'
      @option.present? ? Vendor.by_tag(@option).by_category('eat_drink') : Vendor.by_category('eat_drink')
    else
      Vendor.all
    end
  end

  def all_unapproved_vendors
    Vendor.unscoped.all.where(approved: false, archived: false)
  end

  def filter_name
    @option || 'All'
  end

  def slug
    'TODO'
  end
end

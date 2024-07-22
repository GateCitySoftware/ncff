class VendorIndex
  DATA = Struct.new(:page_name, :vendors, :filter_category, :filter_name, :slug)

  def self.all(category, option)
    new(category, option).call
  end

  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
    DATA.new(page_name, vendors, @category, filter_name, slug)
  end

  private

  def page_name
    Vendor::CATEGORIES[@category.to_sym]
  end

  def vendors
    case @category
    when 'eat_drink'
      @option.present? ? Vendor.by_tag(@option).by_category('eat_drink') : Vendor.by_category('eat_drink')
    else
      Vendor.all
    end
  end

  def filter_name
    @option || 'All'
  end

  def slug
    'TODO'
  end
end

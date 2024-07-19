class VendorIndex
  DATA = Struct.new(:vendors, :filter_category, :filter_name, :slug)

  def self.all(category, option)
    new(category, option).call
  end

  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
    DATA.new(vendors, @category, filter_name, slug)
  end

  private

  def vendors
    case @category
    when 'vendor'
      Vendor.by_tag(@option)
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

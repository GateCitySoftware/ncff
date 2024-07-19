class VendorIndex
  DATA = Struct.new(:vendors, :page_name, :filter_category, :filter_name, :slug)

  def self.all(category, option)
    new(category, option).call
  end

  #  class="nav-link" href="/vendors?category=food-drink">Eat & Drink</a>
  # <a class="nav-link" href="/vendors?category=shop-do">Shop & Do</a>

  def initialize(category, option)
    @category = category
    @option = option
  end

  def call
    DATA.new(vendors, page_name, @category, filter_name, slug)
  end

  private

  def page_name
    Vendor::CATEGORIES[@category.to_sym]
  end

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

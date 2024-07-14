# == Schema Information
#
# Table name: merchants
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  image              :string
#  website            :string
#  social_media_links :json
#  product_type       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

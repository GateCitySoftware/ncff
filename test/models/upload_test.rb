# == Schema Information
#
# Table name: uploads
#
#  id           :bigint           not null, primary key
#  filename     :string
#  content_type :string
#  file_size    :integer
#  key          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class UploadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

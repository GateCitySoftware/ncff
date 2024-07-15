# == Schema Information
#
# Table name: external_links
#
#  id            :bigint           not null, primary key
#  url           :string
#  link_type     :string
#  linkable_type :string           not null
#  linkable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe ExternalLink, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

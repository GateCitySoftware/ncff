# == Schema Information
#
# Table name: embedded_contents
#
#  id              :bigint           not null, primary key
#  url             :string
#  content_type    :string
#  title           :string
#  embed_code      :text
#  description     :text
#  embeddable_type :string           not null
#  embeddable_id   :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe EmbeddedContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

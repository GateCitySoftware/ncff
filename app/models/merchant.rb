# == Schema Information
#
# Table name: merchants
#
#  id           :bigint           not null, primary key
#  name         :string
#  description  :text
#  image        :string
#  website      :string
#  product_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#
class Merchant < ApplicationRecord
  include CardImage
  include Sluggable
  include Uploadable
  include Linkable

  sluggable_attributes :name
end

# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string
#  address     :string
#  phone       :string
#  web_address :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :location do
    name "A location"
    address "Location Street 5 b"
    phone "0402404244"
    web_address "http://www.location.com"
  end
end

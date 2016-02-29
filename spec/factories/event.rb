FactoryGirl.define do
  factory :event do
    name 'An event'
    description 'Something is happening'
    starts_at DateTime.current
    ends_at DateTime.current + 1.hours
  end
end

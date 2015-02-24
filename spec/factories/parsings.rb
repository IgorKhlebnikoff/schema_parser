FactoryGirl.define do
  factory :parsing do
    name { Faker::Lorem.word }
    schema_attachment { File.new("#{Rails.root}/lib/support/schema.txt") }
  end
end

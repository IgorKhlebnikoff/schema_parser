FactoryGirl.define do
  factory :parsing do
    name { Faker::Lorem.word }
    schema_attachment { File.new("#{Rails.root}/lib/support/schema.txt") }
    xml_attachment { File.new("#{Rails.root}/lib/support/LADUSA20150222D.xml") }
  end
end

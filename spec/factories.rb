FactoryBot.define do
  factory :pokemon do 
    name { Faker::Lorem.sentence }
    base_experience { Faker::Number.between }
    height { Faker::Number.between }
    is_default { Faker::Boolean.boolean }
    order { Faker::Number.between }
    weight { Faker::Number.between }
  end

  factory :type do
    name { Faker::Lorem.sentence }
    damage_relations { Faker::Types.rb_hash(number: 4)   }
  end
end


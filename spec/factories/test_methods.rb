FactoryBot.define do
  factory :test_method do
    name "Aerobic Plate Count"
    target_organism "APC"
    reference_method "AOAC"
    turn_around_time 2
    detection_limit 10
    unit 'CFU/g'

    factory :alternate_test_method do
      name "Rapid Y&M"
      target_organism "Y&M"
      turn_around_time 5
      detection_limit 100
    end
    
    factory :invalid_test_method do
      name ""
    end
  end
end

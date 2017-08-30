FactoryGirl.define do
  factory :test_method do
    name "Aerobic Plate Count"
    target_organism "APC"
    reference_method "AOAC"
    turn_around_time 2
    detection_limit 10
    unit 'CFU/g'
    
    factory :invalid_test_method do
      name ""
    end
  end
end
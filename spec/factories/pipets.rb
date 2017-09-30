FactoryGirl.define do
  factory :pipet do
    calibration_date "2017-09-30 08:41:23"
    calibration_due "2017-09-30 08:41:23"
    min_volume 100
    max_volume 1000
    adjustable true
  end
end

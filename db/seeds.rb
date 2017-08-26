test_methods = [ ["APC PF", "APC", "AOAC", 2, 10, "CFU/g"], 
                 ["RY&M PF", "Y&M", "AOAC", 2, 10, "CFU/g"] ]

test_methods.each do |set|
  TestMethod.create(
    name: set[0],
    target_organism: set[1],
    reference_method: set[2],
    turn_around_time: set[3],
    detection_limit: set[4],
    unit: set[5])
end
every :minute do 
  runner "Earthquake."
  rake "now:get_earthquakes"
end

every :hour do
  rake "now:remove_old"
end
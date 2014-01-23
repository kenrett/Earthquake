every 1.minute do 
  rake "now:get_earthquakes"
end

every :hour do
  rake "now:remove_old"
end

# to start crontab, type "whenever -w"
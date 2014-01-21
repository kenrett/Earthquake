namespace :now do  
  task :remove_old => :environment do
    num_cleaned = Earthquake.remove_old.delete_all
    puts "Deleted #{num_cleaned} earthquakes."
  end
end
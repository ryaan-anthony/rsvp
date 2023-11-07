desc "Set the default table positions"
task :table_pos => :environment do
  (1..20).each do |table|
    Guest.coming.where(table: table).each_with_index do |guest, index|
      guest.update(table_pos: index + 1)
    end
  end
end
namespace :data do
  desc "imports data from metrolink csvs"
  task import: :environment do
    Import.run
  end
end

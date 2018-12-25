namespace :create_categories do
  desc "Add categories"
  task run: :environment do
    moto_name_lists = [
      "1 代勁戰", "2 代勁戰", "3 代勁戰", "4 代勁戰", "5 代勁戰", "BW'S", "BW'SR",
      "CUXI100", "CUXI115", "Force 155", "GTR Aero", "RSZero100", "SMAX 155", "T MAX 530",
      "G6", "Racing 150", "RacingS 125/150", "RacingKing 180", "VJR 110", "VJR 125", "Fighter 6代 150",
      "JET S 125", "IRX 115", "RX 110", "JetPowerEVO125", "New fighter 150", "T1", "T2", "T3"
    ]

    moto_name_lists.each do |moto_name|
      Category.find_or_create_by(name: moto_name)
    end
  end
end

namespace :create_categories do
  desc "Add categories"
  task run: :environment do
    moto_lists = [
      "1 代勁戰", "2 代勁戰", "3 代勁戰", "4 代勁戰", "5 代勁戰", "BW'S", "BW'SR",
      "CUXI100", "CUXI115", "Force 155", "GTR Aero", "RSZero100", "SMAX 155", "T MAX 530"
    ]

    moto_lists.each do |moto|
      Category.find_or_create_by(name: moto)
    end
  end
end

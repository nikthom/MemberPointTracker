class PointEntry < ApplicationRecord

    def self.to_csv
        attributes = %w{uin name points_add points_remove comment created_at}

        CSV.generate(headers: true) do |csv|
            csv << attributes

            all.each do |point_entry|
                #csv << attributes.map{ |attr| member.send(attr) }
                csv << point_entry.attributes.values_at(*attributes)
            end
        end
    end
end

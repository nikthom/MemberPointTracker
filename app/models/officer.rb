class Officer < ApplicationRecord
    has_secure_password

    has_many :attendance_entries, {:foreign_key => "uin"}

    def self.to_csv
        attributes = %w{name email position uin points}

        CSV.generate(headers: true) do |csv|
            csv << attributes

            all.each do |officer|
                #csv << attributes.map{ |attr| member.send(attr) }
                csv << officer.attributes.values_at(*attributes)
            end
        end
    end
end

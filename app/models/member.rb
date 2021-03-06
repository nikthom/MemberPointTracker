class Member < ApplicationRecord

    validates_uniqueness_of :uin
    has_many :attendance_entries, {:foreign_key => "uin"}

    def specialDelete
        #find attendance entries to delete
        @attendances = Attendance.where(:uin => self.uin) 
        @attendances.each do |attendance|
            attendance.destroy
        end
        self.destroy
    end


    def self.to_csv
        attributes = %w{name email uin points }

        CSV.generate(headers: true) do |csv|
            csv << attributes

            all.each do |member|
                #csv << attributes.map{ |attr| member.send(attr) }
                csv << member.attributes.values_at(*attributes)
            end
        end
    end

end

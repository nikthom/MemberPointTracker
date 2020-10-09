class Member < ApplicationRecord
  def self.to_csv
    attributes = %w[name email uin points]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |member|
        # csv << attributes.map{ |attr| member.send(attr) }
        csv << member.attributes.values_at(*attributes)
      end
    end
  end
end
